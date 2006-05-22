Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWEVRpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWEVRpt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWEVRpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:45:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26802 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751087AbWEVRps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:45:48 -0400
Date: Mon, 22 May 2006 19:45:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arturzaprzala@ownmail.net
Subject: Re: [PATCH] Fix typo in arch/i386/power/cpu.c
Message-ID: <20060522174507.GB2979@elf.ucw.cz>
References: <4471F1B7.7020203@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4471F1B7.7020203@vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 22-05-06 10:15:35, Zachary Amsden wrote:
> Fix a typo which caused us to corrupt CR2 (not likely a problem) and 
> fail to restore CR0 (potentially a problem on APM systems, since TS/EM 
> bits might be lost) after suspend.

> Fix a typo in suspend code noticed by Artur Zaprzala.  I'm unsure if this
> actually causes a bug in practice, since the ACPI wakeup code also restores
> CR0, and the APM code returns to protected mode, but the fix is obviously much
> better.
> 
> Signed-off-by: Zachary Amsden <zach@vmware.com>

I believe it is already queued in -mm tree. If you actually know know
a system it breaks (or if it breaks vmware), we have very good reason
to push it now.
                                                                Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
