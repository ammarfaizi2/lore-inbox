Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbWD1RCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWD1RCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWD1RAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:00:55 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:23248 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751803AbWD1RAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:00:48 -0400
Message-ID: <44524A3F.6060203@tlinx.org>
Date: Fri, 28 Apr 2006 10:00:47 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: make O="<dir>" install; output not relocated; 2.6.16.11(kbuild)
References: <4451B77D.7070000@tlinx.org> <20060428075832.GD25520@lug-owl.de>
In-Reply-To: <20060428075832.GD25520@lug-owl.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> The  modules_install  target uses O= for its _input_ files (that is,
> for the readily compiled modules) and outputs to
> $(INSTALL_MOD_PATH)/lib/modules/$VERSION/ .  So you may want to set
> $(INSTALL_MOD_PATH) in the same way as you've set V= or O= before.
>
> If you're trying to prepare something to be copied over to a target
> system, the tar-pkg, targz-pkg and tarbz2-pkg targets may be exactly
> what you're searching for.
>   
Quite possibly. What about an installed kernel (apart from the
modules)?  Will the kernel image and map, etc, get installed into
the "INSTALL_MOD_PATH" as well?  It doesn't sound, intuitively,
to be so from the environment variable name.
> It's maybe a bit misleading, but `modules_install' isn't a compilation
> run, it's an installation run. O= was ment to hold all
> compiled/generated objects, but to have a working installation, you
> need to break out of that (or have INSTALL_MOD_PATH set.)
>   
---
    Fair enough, but I'm more interested in where to specify
the target location of the installed kernel and System.map as
I don't always have modules for a generated kernel, but usually
(near 100% :-)) have an installable kernel image.  For development,
I could see it being useful to mount the target system's root in
a local directory (like /mnt), then have the kernel build install
to a target root of "/mnt".

Tnx,
Linda



