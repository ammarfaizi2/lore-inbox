Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUG1XMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUG1XMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUG1XMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:12:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:43187 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267326AbUG1XLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:11:33 -0400
Date: Wed, 28 Jul 2004 16:14:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: mochel@digitalimplant.org, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: -mm swsusp: do not default to platform/firmware
Message-Id: <20040728161448.336183e2.akpm@osdl.org>
In-Reply-To: <20040728222445.GA18210@elf.ucw.cz>
References: <20040728222445.GA18210@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> -mm swsusp now defaults to platform/firmware suspend... That's
> certainly unexpected, changes behaviour from previous version, and
> only works on one of three machines I have here. I'd like the default
> to be changed back.

You overestimate my knowledge of suspend stuff.  AFAICT the current -mm
default is to enter ACPI sleep state via the BIOS rather than via Linux's
ACPI driver.  Correct?

If not, then what?

If so, then why do we feel this change is needed, and why did Pat change things?

My major concern here is that Pat may have made that change to get suitable
coverage testing for new code paths, and we wouldn't want to undo that right away.

