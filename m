Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTDQBsJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 21:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbTDQBsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 21:48:08 -0400
Received: from fmr01.intel.com ([192.55.52.18]:11972 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262406AbTDQBsI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 21:48:08 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C262E38@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'ranty@debian.org'" <ranty@debian.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: firmware separation filesystem (fwfs)
Date: Wed, 16 Apr 2003 19:00:00 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: David Gibson [mailto:david@gibson.dropbear.id.au]
> 
> Incidentally another approach that also avoids nasty ioctl()s would be
> to invoke the userland helper with specially set up FD 1, which lets
> the kernel capture the program's stdout. 

I think this makes too many assumptions specially taking into
account that most hotplug stuff are shell scripts - they are
probably going to be writing all kinds of stuff to stdout.

With the risk of repeating myself (again) and being a PITA,
I really think it'd be easier to copy the firmware file to a 
/sysfs binary file registered by the device driver during 
initialization; then the driver can wait for the file to be
written with a valid firmware before finishing the init
sequence. The infrastructure is already there (or isn't ... 
is it?).

CU,

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
