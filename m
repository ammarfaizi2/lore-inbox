Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTDOLQy (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 07:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264438AbTDOLQy (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 07:16:54 -0400
Received: from ns.suse.de ([213.95.15.193]:44041 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264437AbTDOLQy (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 07:16:54 -0400
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writing modules for 2.5
References: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Apr 2003 13:28:21 +0200
In-Reply-To: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel>
Message-ID: <p73adesxane.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (Måns Rullgård) writes:

> What magic needs to be done when writing modules for linux 2.5.x?
> Insmod tells me "Invalid module format" and the kernel log says "No
> module found in object".  I've tried to mimic the foo.mod.c stuff in
> the kernel tree, but I can't figure out the right way to do it.

Welcome to the wonderful new world of in kernel module loading, finally
with understandable error messages. Now bad error reporting is not limited
to netlink anymore.

You need -DKBUILD_BASENAME=name

Also you need module_init/module_exit declarations.

-Andi
