Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUJIUKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUJIUKt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUJIUKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:10:47 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:52440 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S267354AbUJIUJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:09:48 -0400
Message-ID: <009801c4ae44$59936ea0$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "Andries Brouwer" <aebr@win.tue.nl>, "Kyle Moffett" <mrmacman_g4@mac.com>
Cc: "Andries Brouwer" <aebr@win.tue.nl>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
References: <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156727.31753.44.camel@localhost.localdomain> <001f01c4ac8b$35849710$161b14ac@boromir> <1097160628.31614.68.camel@localhost.localdomain> <20041007215834.GA7047@pclin040.win.tue.nl> <CE341A74-18B0-11D9-ABEB-000393ACC76E@mac.com> <20041007224640.GC7047@pclin040.win.tue.nl> <EE2D21FC-18B8-11D9-ABEB-000393ACC76E@mac.com> <20041008091933.GD7047@pclin040.win.tue.nl>
Subject: Re: mmap specification - was: ... select specification
Date: Sat, 9 Oct 2004 22:10:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andries Brouwer" <aebr@win.tue.nl>
> On Thu, Oct 07, 2004 at 07:30:53PM -0400, Kyle Moffett wrote:
> > On Oct 07, 2004, at 18:46, Andries Brouwer wrote:
> > >The POSIX text is clear to me, and Linux is compliant.
> > >On the other hand, I have no idea what you try to say.
> > 
> > >On Thu, Oct 07, 2004 at 06:32:43PM -0400, Kyle Moffett wrote:
> > >
> > >>>>"References within the address range starting at pa and continuing
> > >>>>for len bytes to whole pages following the end of an object shall
> > >>>>result in delivery of a SIGBUS signal."
> > 
> > Reviewing this once more:
> > 
> > >References within the address range starting at pa and continuing for
> > >len bytes:
> > range = {pa ... pa+len};
> > 
> > >To whole pages following the end of an object:
> > range = {pa ... PAGE_ROUND_UP(pa+len)};
> 
> It is here you are wrong.

Indeed, I think Kyle took ``end of an object'' to mean the end of the
mapping instead of the end of what is mapped, e.g. EOF in case of a file.


--ms


