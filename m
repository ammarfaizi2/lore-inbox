Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUA3Q7C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUA3Q7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:59:02 -0500
Received: from [207.111.197.98] ([207.111.197.98]:38926 "EHLO www.igotu.com")
	by vger.kernel.org with ESMTP id S262328AbUA3Q64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:58:56 -0500
From: "Martin Bogomolni" <martinb@www.igotu.com>
To: Michael Knigge <Michael.Knigge@set-software.de>,
       Markus Schaber <schabios@logi-track.com>
Cc: linux-kernel@vger.kernel.org
Reply-To: martinb@igotu.com
Subject: Re: Errors with USB Disk
Date: Fri, 30 Jan 2004 11:30:37 -0500
Message-Id: <20040130162256.M39489@www.igotu.com>
In-Reply-To: <20040130.11444335@knigge.local.net>
References: <20040130122324.7ac7ef34.schabios@logi-track.com> <20040130.11444335@knigge.local.net>
X-Mailer: Open WebMail 2.21 20031110
X-OriginatingIP: 12.100.203.195 (martinb)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael, Markus, Et. Al.

We are seeing the same problem ( USB hangs ) on 2.4.24 and 2.4.25-pre7 w/ the
patches submitted by Oliver and Alan S.   We're copying about 15GiB of data
between an IDE and USB drive, and see the hang occur somewhere in the first
1GiB of data transferred.   

Changing max_sectors to 128/64/32/16/8 in the scsiglue.c doesn't make any
difference as far as stability goes.  Unfortunately, once the system locks up,
it ceases responding even to the SysCtl hack. 

I'm in the process of performing tests on various platforms and verbose
logging usb_storage via serial console.  As soon as I have some results I will
be posting them to the linux-usb-devel list.

Martin 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
 
iD8DBQFAGAwugZQNxll+EIcRAi5QAJwPVaycmtXpTpfRlO+1BJaQUSbEwQCgltX6
qQ1ruCegNDc+w82h9iPT+Zc=
=FTcP
-----END PGP SIGNATURE-----

