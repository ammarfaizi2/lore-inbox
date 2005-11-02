Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbVKBWUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbVKBWUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbVKBWUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:20:07 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:32972 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1751511AbVKBWUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:20:05 -0500
Date: Wed, 2 Nov 2005 23:20:30 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Subject: initramfs for /dev/console with udev?
Message-ID: <20051102222030.GP23316@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

If I understand Documentation/early-userspace/README correctly it should
be possible to solve the "unable to open an initial console" problem by
using a file like 

dir /dev 0755 0 0
nod /dev/console 0600 0 0 c 5 1
nod /dev/null 0600 0 0 c 1 3
dir /root 0700 0 0

and let CONFIG_INITRAMFS_SOURCE point to that file. The gpio archive is
built correctly with that, but my kernel doesn't seem to use it. 

Is anything else needed to use an initrd, like a command line argument?
My kernel boots from a nfs partition, so it sets nfsroot=... 

As I still get the "unable to open an initial console" message it looks
like the initramfs is not extracted, mounted or however that works. 

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

