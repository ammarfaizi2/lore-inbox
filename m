Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbVLRA3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVLRA3T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 19:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVLRA3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 19:29:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27313 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965033AbVLRA3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 19:29:19 -0500
Subject: Re: [openib-general] Re: [PATCH 13/13] [RFC] ipath Kconfig and
	Makefile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Walsh <rjwalsh@pathscale.com>
Cc: Adrian Bunk <bunk@stusta.de>, Roland Dreier <rolandd@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1134860084.20575.101.camel@phosphene.durables.org>
References: <200512161548.MdcxE8ZQTy1yj4v1@cisco.com>
	 <200512161548.lokgvLraSGi0enUH@cisco.com>
	 <20051217215251.GV23349@stusta.de>
	 <1134860084.20575.101.camel@phosphene.durables.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 18 Dec 2005 00:27:03 +0000
Message-Id: <1134865624.11953.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-12-17 at 14:54 -0800, Robert Walsh wrote:
> Agreed about the assembler, but one way or the other, x86_64 is the only
> arch we support.

If you need a quad only copy then put it into asm/string.h (asm/io.h if
its operating on I/O space I guess) or somewhere similar as a generic
function that does just that. That allows people to come along and
provide the same functions for other platforms if they need it, and also
makes it possible for others to use this feature if their hardware has
the same feature.

Nobody expects you as a vendor to support it on sparc64, x86-32 or
whatever, nor to write sparc64 asm functions just to make it possible
for someone to do so cleanly later on.

