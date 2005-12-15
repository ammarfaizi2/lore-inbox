Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVLOWno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVLOWno (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVLOWnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:43:43 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:17287 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751142AbVLOWnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:43:43 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH -mm 0/2] Additional function in swapfile.c (needed for swap suspend)
Date: Thu, 15 Dec 2005 23:29:07 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512152329.08537.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To implement the image-writing part of swsusp in the user space and maintain
the compatibility with the in-kernel implementation we need to be able to
ask the kernel to allocate a swap page from specific swap partition.  For this
purpose we need a function allowing us to specify the swap partition to
allocate from.

Moreover, if we had such a function, we could change the in-kernel
implementation of swsusp to avoid locking of the swap devices that
are not used for suspend and this would allow us to simplify the code
quite a bit.

The first of the following two patches adds such a function, and the second
of them shows what can be done in swsusp if that function is available.

All of your comments and/or suggestions will be appreciated.

Greetings,
Rafael

