Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVCAJx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVCAJx3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 04:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVCAJx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 04:53:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:25989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261844AbVCAJx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 04:53:26 -0500
Date: Tue, 1 Mar 2005 01:52:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, barryn@pobox.com, <marado@student.dei.uc.pt>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-Id: <20050301015231.091b5329.akpm@osdl.org>
In-Reply-To: <20050228231721.GA1326@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> In `subj` kernel, machine no longer powers down at the end of
>  swsusp. 2.6.11-rc5-pavel works ok, as does 2.6.11-bk.

Binary searching indicates that this is due to
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc5/2.6.11-rc5-mm1/broken-out/acpi_power_off-bug-fix.patch.

I'll drop it.  That patch is pretty ugly-looking anyway (ACPI code in
drivers/base/power/?).

Perhaps someone who is hitting the problem which that patch addresses could
raise a bugzilla entry.

Oh.  It has one.  http://bugme.osdl.org/show_bug.cgi?id=4041

Anyway.  It needs more work.
