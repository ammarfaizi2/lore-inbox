Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314578AbSEBPpo>; Thu, 2 May 2002 11:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314582AbSEBPpn>; Thu, 2 May 2002 11:45:43 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:29709 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S314578AbSEBPpm>; Thu, 2 May 2002 11:45:42 -0400
Date: Thu, 2 May 2002 17:44:23 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what replaces tq_scheduler in 2.4
Message-ID: <20020502174423.L696@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20020427.194302.02285733.davem@redhat.com><467685860.avixxmail@nexxnet.epcnet.de> <20020428.204911.63038910.davem@redhat.com> <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu> <005d01c1efcb$561b8c10$e6f7ae80@ad.uiuc.edu> <001a01c1f094$8d572850$e6f7ae80@ad.uiuc.edu> <3CCF1B39.94CF0152@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
hi others,

On Tue, Apr 30, 2002 at 03:31:21PM -0700, Andrew Morton wrote:
> Wanghong Yuan wrote:
> > It seems that tq_scheduler disappears in Linux 2.4. SO what can I do if I
> > need to do something when the scheduler wakes up. The old code likes
> > 
> 
> All users of tq_scheduler were using it as a way of running
> process-context code shortly after the occurrence of an
> interrupt.  They were moved over to using schedule_task().
> Probably, that is what you want.

What is the main difference between tq_immediate and the former
tq_scheduler?

I would like to know, whether I can convert my old bh routines[1] to
that new mechanism.

Thanks & Regards

Ingo Oeser

[1] Note to German readers: I mean interrupt backends! Nothing
   else :-)
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
