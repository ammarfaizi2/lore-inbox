Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSECANU>; Thu, 2 May 2002 20:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315486AbSECANT>; Thu, 2 May 2002 20:13:19 -0400
Received: from mx2.ews.uiuc.edu ([130.126.161.238]:49822 "EHLO
	mx2.ews.uiuc.edu") by vger.kernel.org with ESMTP id <S315485AbSECANS>;
	Thu, 2 May 2002 20:13:18 -0400
Message-ID: <005e01c1f237$4f88e820$e6f7ae80@ad.uiuc.edu>
From: "Wanghong Yuan" <wyuan1@ews.uiuc.edu>
To: "Ingo Oeser" <ingo.oeser@informatik.tu-chemnitz.de>,
        "Andrew Morton" <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020427.194302.02285733.davem@redhat.com><467685860.avixxmail@nexxnet.epcnet.de> <20020428.204911.63038910.davem@redhat.com> <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu> <005d01c1efcb$561b8c10$e6f7ae80@ad.uiuc.edu> <001a01c1f094$8d572850$e6f7ae80@ad.uiuc.edu> <3CCF1B39.94CF0152@zip.com.au> <20020502174423.L696@nightmaster.csn.tu-chemnitz.de>
Subject: Re: what replaces tq_scheduler in 2.4
Date: Thu, 2 May 2002 19:13:10 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI, Ingo

Did you get the answer? Please cc me


> Hi Andrew,
> hi others,
>
> On Tue, Apr 30, 2002 at 03:31:21PM -0700, Andrew Morton wrote:
> > Wanghong Yuan wrote:
> > > It seems that tq_scheduler disappears in Linux 2.4. SO what can I do
if I
> > > need to do something when the scheduler wakes up. The old code likes
> > >
> >
> > All users of tq_scheduler were using it as a way of running
> > process-context code shortly after the occurrence of an
> > interrupt.  They were moved over to using schedule_task().
> > Probably, that is what you want.
>
> What is the main difference between tq_immediate and the former
> tq_scheduler?
>
> I would like to know, whether I can convert my old bh routines[1] to
> that new mechanism.
>
> Thanks & Regards
>
> Ingo Oeser
>
> [1] Note to German readers: I mean interrupt backends! Nothing
>    else :-)
> --
> Science is what we can tell a computer. Art is everything else. ---
D.E.Knuth
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

