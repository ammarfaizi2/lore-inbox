Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUF3Vvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUF3Vvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 17:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUF3Vvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 17:51:37 -0400
Received: from grex.cyberspace.org ([216.93.104.34]:7436 "HELO
	grex.cyberspace.org") by vger.kernel.org with SMTP id S263001AbUF3Vvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 17:51:36 -0400
Date: Wed, 30 Jun 2004 17:52:30 -0400 (EDT)
From: Joshua <jhudson@cyberspace.org>
To: Timothy Miller <miller@techsource.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore floppy boot image
In-Reply-To: <40E3319D.3050100@techsource.com>
Message-ID: <Pine.SUN.3.96.1040630174704.20503A-100000@grex.cyberspace.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the time in reading the patch.

Hmm. pop %ax after the jmp is a clear bug. Must have been a zero
on the stack when I tested it. <g>

For the clobbering of al just before kernel entry, that is badly arranged
code although it doesn't matter (mov $0, %al turns out to be no-op).

I'll fix the bugs if anybody still wants the patch.
I'll fix it anyway for myself <g>.

