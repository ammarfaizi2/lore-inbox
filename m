Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSGNSVx>; Sun, 14 Jul 2002 14:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317003AbSGNSVw>; Sun, 14 Jul 2002 14:21:52 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:15576 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316997AbSGNSVv>; Sun, 14 Jul 2002 14:21:51 -0400
Date: Sun, 14 Jul 2002 20:22:54 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141822.g6EIMsho019330@burner.fokus.gmd.de>
To: riel@conectiva.com.br, schilling@fokus.gmd.de
Cc: aia21@cantab.net, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Rik van Riel <riel@conectiva.com.br>

>> Well, I get pissed of the fact that it seems to be impossible to have a
>> technical based discussion in the Linux kernel environment.

>Then please, show us your technical arguments on why the SCSI
>layer is enough for every CD writing hardware out there.

Simple: there is not a single CD writer out that uses something other
than SCSI commands to write media or do DAE.


>Now compare them with the results from the NAS and SCSI talks
>and BoFs at the kernel summit and OLS, where everybody agreed
>that the current SCSI addressing and discovery schemes just
>don't cut it on things like iscsi and other network storage
>solutions.

I defined RSCSI before iscsi came out. I did not yet look at ISCSI.
There sould be just an additional IP address in the iscsi addressing
model.

>It's not just about the fact that the controller/bus/unit/lun
>addressing doesn't deal well with network attached storage and
>multipath, it's also about things like the impossability of
>device discovery on a bus with 2^32 possible device addresses.

You don't need as you might net be allowed to access many of them.
Just have a look at my RSCSI protocol. It just puts "user@host:"
before the old SCSI address.

>This, in turn, makes the current sd[a-z] and sg[a-h] more than
>a little inadequate.  Furthermore, you suddenly require the
>ability to tell the kernel to talk to devices the kernel doesn't
>yet know about (because it can't scan 2^32 device addresses at
>boot time).

You are right, but this is what programs like e.g. cdrtools which use
libscg already do for two years.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
