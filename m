Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSECSCX>; Fri, 3 May 2002 14:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314941AbSECSCW>; Fri, 3 May 2002 14:02:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51976 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314938AbSECSCW>;
	Fri, 3 May 2002 14:02:22 -0400
Message-ID: <3CD2D120.4DE377A0@zip.com.au>
Date: Fri, 03 May 2002 11:04:16 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: what replaces tq_scheduler in 2.4
In-Reply-To: <20020427.194302.02285733.davem@redhat.com><467685860.avixxmail@nexxnet.epcnet.de> <20020428.204911.63038910.davem@redhat.com> <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu> <005d01c1efcb$561b8c10$e6f7ae80@ad.uiuc.edu> <001a01c1f094$8d572850$e6f7ae80@ad.uiuc.edu> <3CCF1B39.94CF0152@zip.com.au> <20020502174423.L696@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> ...
> What is the main difference between tq_immediate and the former
> tq_scheduler?

tq_immediate looks to be some very old piece of kernel infrastructure
which is somewhat obsolete but all the users have not been converted
to yet.  May run in interrupt context.  

tq_scheduler callbacks run in process context.  Use schedule_task()
instead.

These mechanisms are discussed in the Rubini/Corbet bible:
http://www.xml.com/ldd/chapter/book/
