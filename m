Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265775AbUF2Osk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUF2Osk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 10:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUF2Osk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 10:48:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:31939 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265775AbUF2Osi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 10:48:38 -0400
From: Patrick Dreker <patrick@dreker.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: IDE Timeout problem on Intel PIIX3 (Triton 2) chipset
Date: Tue, 29 Jun 2004 16:48:35 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200406281448.15725.patrick@dreker.de> <200406282221.48896.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200406282221.48896.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406291648.35114.patrick@dreker.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:55d40479e9cc6e4ab087ddd2b9b4bce4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 28. Juni 2004 22:21 schrieb Bartlomiej Zolnierkiewicz:
> > What can I do to debug this problem?
> "diff -u" on "lspci -s 07.1 -xxx" outputs for 2.4.20 and 2.4.21 kernels.
>
> Doing bisection search on 2.4.21-pre kernels would also help.
2.4.21-pre1 is the first non-working kernel, 2.4.20 works. When generating the 
configs for 2.4.21-pre1 (make oldconfig based on the working 2.4.20 config) I 
was asked "Use IDE Taskfile I/O" which defaulted to no and I kept that 
default (i.e. "Don't use Taskfile I/O").

lspci -s 07.1 -xxx shows no difference between a working (2.4.20) kernel and a 
non-working (2.4.21-pre1) kernel.

This caught my eye, but was probably obvious to you:
2.4.21-pre1 reports IDE Version 7.00beta-2.4 while 2.4.20 reports version 6.31

Patrick
-- 
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers
