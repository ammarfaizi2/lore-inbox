Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSD3Wch>; Tue, 30 Apr 2002 18:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315250AbSD3Wcg>; Tue, 30 Apr 2002 18:32:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58629 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315245AbSD3Wcf>;
	Tue, 30 Apr 2002 18:32:35 -0400
Message-ID: <3CCF1B39.94CF0152@zip.com.au>
Date: Tue, 30 Apr 2002 15:31:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Wanghong Yuan <wyuan1@ews.uiuc.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: what replaces tq_scheduler in 2.4
In-Reply-To: <20020427.194302.02285733.davem@redhat.com><467685860.avixxmail@nexxnet.epcnet.de> <20020428.204911.63038910.davem@redhat.com> <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu> <005d01c1efcb$561b8c10$e6f7ae80@ad.uiuc.edu> <001a01c1f094$8d572850$e6f7ae80@ad.uiuc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wanghong Yuan wrote:
> 
> Hi,
> 
> It seems that tq_scheduler disappears in Linux 2.4. SO what can I do if I
> need to do something when the scheduler wakes up. The old code likes
> 

All users of tq_scheduler were using it as a way of running
process-context code shortly after the occurrence of an
interrupt.  They were moved over to using schedule_task().
Probably, that is what you want.

If you specifically have a need to know when the
scheduler is entered then there is no longer a way of
doing that.

-
