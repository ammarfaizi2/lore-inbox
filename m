Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265379AbSJXKFa>; Thu, 24 Oct 2002 06:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265380AbSJXKFa>; Thu, 24 Oct 2002 06:05:30 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:6176 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S265379AbSJXKF3>; Thu, 24 Oct 2002 06:05:29 -0400
Date: Thu, 24 Oct 2002 13:11:26 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: James Stevenson <james@stev.org>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: One for the Security Guru's
Message-ID: <20021024101126.GQ147946@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	James Stevenson <james@stev.org>, ebiederm@xmission.com,
	linux-kernel@vger.kernel.org
References: <20021023130251.GF25422@rdlg.net> <1035411315.5377.8.camel@god.stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035411315.5377.8.camel@god.stev.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 11:15:14PM +0100, you [James Stevenson] wrote:
> 
> As to load a module you must be root and if you are root you
> can read / write disks. Thus you could recompile your own kernel
> install it try to force a crash or a reboot which is not hard as root
> and the person may not even notice that the kernel has grown by a few
> bytes after the crash.

Which is why some people configure kernels not to support installing modules
and only use read-only media (e.g. CD-R) for booting. Sure, there's still
the /dev/kmem hole, but this closes 2 classes of attacks - loading rootkit
module and booting with a hacked kernel in straight-forward way.

BTW, this might be a reason to make kexec syscall to be a config option (if
it isn't already.) The other reason is to avoid bloat for people that don't
need it, but perhaps this is a stronger argument. I realize you can propably
launch the kernel by hand (using /dev/kmem etc) if you really know what to
do. But the same applies to adding code/patching kernel without
CONFIG_MODULES support.


-- v --

v@iki.fi
