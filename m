Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTEGLtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 07:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTEGLtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 07:49:06 -0400
Received: from h-64-105-35-101.SNVACAID.covad.net ([64.105.35.101]:5780 "EHLO
	adam.yggdrasil.com") by vger.kernel.org with ESMTP id S263128AbTEGLtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 07:49:01 -0400
Date: Wed, 7 May 2003 04:59:11 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200305071159.h47BxBe04974@adam.yggdrasil.com>
To: simon@thekelleys.org.uk
Subject: Re: Binary firmware in the kernel - licensing issues.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kelley wrote:
>Now Linus could say "I consider that the kernel copyright holders 
>did/didn't give permission to combine  their work with firmware blobs" 
>and I contend that practically all the copyright holders would go along
>with that judgement, just as they went along with Linus's judgement
>about linking binary-only modules with their work.

	I am not a lawyer.  So, please do not rely on this as legal advice.

	I think you are confusing people having a strong distaste
for suing their fellow developers with people agreeing to something.
Also, your theory would require explicit unanimous agreement of the
contributors of GPL'ed kernel code if you actually want to guarantee
anything.

	By the way, there are some additional advantages to not compiling
in the firmware that perhaps you might not have contemplated.  Reducing
people's perceived legal exposure would most likely help adoption of
your driver.  Separate firmware loading also offers more upgradability
and, therefore, maintainability and perhaps extensibility if people
want to try firmware improvements (for example the WiFi frequencies
available for use are different in different countries and there may
also be different power limits or other requirements).  Finally, you
would avoid the need to keep a copy of the firmware in unswappable
kernel memory if your driver supports hot plugging (since a device
could be plugged in at any time, not just at driver initialization).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
