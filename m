Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269885AbRHEA4d>; Sat, 4 Aug 2001 20:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269889AbRHEA4X>; Sat, 4 Aug 2001 20:56:23 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:12283
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S269885AbRHEA4P>; Sat, 4 Aug 2001 20:56:15 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: <rich+ml@lclogic.com>, <linux-kernel@vger.kernel.org>
Subject: Re: module unresolved symbols
Date: Sat, 4 Aug 2001 19:49:02 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.30.0108041726050.8186-100000@baddog.localdomain>
In-Reply-To: <Pine.LNX.4.30.0108041726050.8186-100000@baddog.localdomain>
MIME-Version: 1.0
Message-Id: <01080419561700.08008@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Aug 2001, rich+ml@lclogic.com wrote:
>Hi all, kindly redirect me if this is the wrong list.
>
>Starting with a stock RH 7.0 install, I changed a single kernel config
>item and recompiled with 'make defs clean bzImage modules
>modules_install'.
>
>Booted on the new kernel and depmod complains that dozens of modules
>contain unresolved symbols. Back to the original kernel, now it also
>complains of unresolved symbols (not the same set of modules, and modules
>that were previously OK).
>
>I can't find an answer on the net, does anyone know how to fix this?
>
>Thanks == Rich

This id due to the change in parameters and kernel rebuild. The default
kernel used a different configuration than the one in the src directory,
even though the kernel name was the same.

What I do to keep this from happening is to change the "EXTRAVERSION" in the
src/linux/Makefile.

As long as this is different from the distributed kernel name then a new
/lib/modules/xxx/... directory will be created. That directory will contain
the new modules instead of the default one.

To repair the damage, you will need your backup (or reload them from the
distribution).

An alternative - If you copied the src tree before changing the configuration
you can try a "make modules_install" in the original directory. This IS
assuming that that tree is the one used for the default kernel.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
