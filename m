Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbULVSPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbULVSPK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 13:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbULVSPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 13:15:10 -0500
Received: from hermes.safetyhost.net ([217.147.200.20]:11498 "EHLO
	hermes.safetyhost.net") by vger.kernel.org with ESMTP
	id S261789AbULVSPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 13:15:05 -0500
Subject: kernel-source bug for sparc architecture
From: Regis Leclerc <regis@safety-host.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 22 Dec 2004 19:15:02 +0100
Message-Id: <1103739302.21581.11.camel@smaug.safetyhost.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I am compiling kernel 2.6.9 on a sparc32 architecture (SUN4C) with
GCC3.3.4, and found that drivers/video/bw2.c has a compilation problem
on line 389.

There is a call that passes &options as 2nd argument, but the "options"
variable isn't defined anywhere.

In drivers/video/cg6.c there is the same kind of call, but it passes
NULL instead of &options, so I altered bw2.c to replace &options with
NULL, so the compilation can go on (it's a part of the make image part).

I am not a specialist of video drivers on sparc32 (I have a CG6,
anyway), but I'm reporting this compilation problem so a true specialist
of this part of the code can raise an eyebrow on it.

thank you for your attention,
regards,
Regis
-- 
Regis Leclerc <regis@safety-host.com>

