Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292188AbSBTS5g>; Wed, 20 Feb 2002 13:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292182AbSBTS5W>; Wed, 20 Feb 2002 13:57:22 -0500
Received: from [212.159.14.225] ([212.159.14.225]:39929 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S292185AbSBTS5A>; Wed, 20 Feb 2002 13:57:00 -0500
Date: Wed, 20 Feb 2002 18:58:55 +0000
From: "J.P. Morris" <jpm@it-he.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-rc2 problem..
Message-Id: <20020220185855.2bcecc24.jpm@it-he.org>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm getting a problem in usb-storage (it's loaded as a module towards the end
of the boot sequence).  The module locks during initialisation, which doesn't
happen in 2.4.17.
(is it possible to unload a crashed module without rebooting?
 This happens so often with SCSI... )

The culprit seems to be my new usb CF reader.  Unfortunately it's unbranded
and I can't identify the underlying hardware.  None of the specific drivers
(e.g. sandisk, lexar, microtech, freecom) need to be loaded for it to work,
so I guess there's some generic protocol for usb->scsi?

Regardless, unless someone else has an idea, I'm going to try manually
merging the usb-storage changes in from 2.4.17 to 2.4.18-rc2 until it
breaks to try and isolate the problem..

-- 
JP Morris - aka DOUG the Eagle (Dragon) -=UDIC=-  doug@it-he.org
Fun things to do with the Ultima games            http://www.it-he.com
Developing a U6/U7 clone                          http://ire.it-he.org
d+++ e+ N+ T++ Om U1234!56!7'!S'!8!9!KA u++ uC+++ uF+++ uG---- uLB----
uA--- nC+ nR---- nH+++ nP++ nI nPT nS nT wM- wC- y a(YEAR - 1976)
