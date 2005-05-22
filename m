Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVEVDXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVEVDXR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 23:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVEVDXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 23:23:17 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:46686 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261722AbVEVDXK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 23:23:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SQOdV1A7N3DobCkk+/PB3t1753Y77V3j5cxJ5nECwOxJLdrsG+lcczPCuTLekU0GR68F8doKtjqjIAsFi5lVzdbPCi5Bn+e8EK8oVZ3rAJpsmt1gYFp3Q5WP2G08+cCBnH8bb0jStyDDgbORCO6IbhBpsYjEow/P9ACqJgPldIA=
Message-ID: <54b5dbf505052120237b557777@mail.gmail.com>
Date: Sun, 22 May 2005 08:53:09 +0530
From: AsterixTheGaul <asterixthegaul@gmail.com>
Reply-To: AsterixTheGaul <asterixthegaul@gmail.com>
To: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] Add sysfs support for the IPMI device interface
Cc: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <54b5dbf50505212020e595cd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <428D208C.1000307@acm.org> <20050520065623.GA11075@titan.lahn.de>
	 <428DDF6C.5080701@acm.org> <54b5dbf50505212020e595cd2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry dint copy the full mkpatch output. Here is the full output....


Signed-off by AsterixTheGaul <asterixthegaul@gmail.com>

Compile fix  ipmi_devintf.c for problem introduced by the commit change
37e0915b701281182cea9fc90e894d10addf134a

---
commit 1f974bf04b1f2a01e189e01970cb744343ad1bb7
tree c7b157f4d23340a6d773b8d1385c0efb21d4b650
parent b5c44c2147a447f77e07fecdb087ae288e1f4e40
author AsterixTheGaul <asterixthegaul@gmail.com> Sat, 21 May 2005 20:16:39 +0530
committer AsterixTheGaul <asterixthegaul@gmail.com> Sat, 21 May 2005
20:16:39 +0530
 char/ipmi/ipmi_devintf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- ec1d95eb1e03e320fc5eb5cfb40379f2f4a7267d/drivers/char/ipmi/ipmi_devintf.c
 (mode:100644)
+++ c7b157f4d23340a6d773b8d1385c0efb21d4b650/drivers/char/ipmi/ipmi_devintf.c
 (mode:100644)
@@ -520,7 +520,7 @@
                 " interface.  Other values will set the major device number"
                 " to that value.");

-static struct class *ipmi_class;
+static struct class_simple *ipmi_class;

 static void ipmi_new_smi(int if_num)
 {
@@ -534,7 +534,7 @@

 static void ipmi_smi_gone(int if_num)
 {
-       class_simple_device_remove(ipmi_class, MKDEV(ipmi_major, if_num));
+       class_simple_device_remove(MKDEV(ipmi_major, if_num));
        devfs_remove("ipmidev/%d", if_num);
 }
