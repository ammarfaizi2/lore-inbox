Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272921AbTHAVp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 17:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274957AbTHAVp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 17:45:26 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:56329 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S272921AbTHAVpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 17:45:03 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: module-init-tools - input devices id support
Date: Sat, 2 Aug 2003 01:29:51 +0400
User-Agent: KMail/1.5
Cc: Rusty Russell <rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PvtK/rOpjZxCGrG"
Message-Id: <200308020129.51737.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_PvtK/rOpjZxCGrG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

this adds support for generating modules.inputmap with input handler match 
table that is used by input hotplug agent posted separately. Using hotplug 
allowed me to completely eliminate any manual (input handler) module loading 
in 2.6, it is also compatible with 2.4 in that usb.agent for 2.4 includes 
fake usb table that maps device class to input handlers so this is mostly 
transparent to users.

I do not have ability to test it on 64 bit system nor have any sufficient 
knowledge about ELF - please, check and adjust table size if neccessary.

the patch is against 0.9.13-pre and relative to previous temp file patch I 
sent. I can send patch against vanilla version if required.

Comments appreciated

-andrey
--Boundary-00=_PvtK/rOpjZxCGrG
Content-Type: application/x-bzip2;
  name="module-init-tools-0.9.13-inputmap.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="module-init-tools-0.9.13-inputmap.patch.bz2"

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
z+syOwjcRP+LuSKcKEgxMufngA==

--Boundary-00=_PvtK/rOpjZxCGrG--

