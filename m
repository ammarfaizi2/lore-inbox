Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSDQSXl>; Wed, 17 Apr 2002 14:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311577AbSDQSXk>; Wed, 17 Apr 2002 14:23:40 -0400
Received: from ns.suse.de ([213.95.15.193]:29194 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311564AbSDQSXk>;
	Wed, 17 Apr 2002 14:23:40 -0400
Date: Wed, 17 Apr 2002 20:23:36 +0200
From: Dave Jones <davej@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5.8] support for NCR voyager (3/4/5xxx series)
Message-ID: <20020417202336.I29982@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204161601.g3GG1nP03345@localhost.localdomain> <m1wuv6fdad.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 11:25:14AM -0600, Eric W. Biederman wrote:

 > Currently you place the voyager information in the APM table,  which is problematic
 > for the goal of being able to have a kernel that will support everything,
 > and it is a little confusing.

Kernels for many of the x86 subarch's that are popping up won't "do the
right thing" on any 'normal' x86 if memory serves me correctly. For eg
a kernel for IBM summit machines won't work on a regular PC.
Getting them to do so would require things like apic.c to become an even
bigger mess than what it currently is

The idea behind the subarch patches is that you get a kernel
specifically for your weirdo machine, whilst keeping the common code
free of ifdefs and other uglies. So we'd end up with perhaps..

 o  regular i386 boot on any PC kernel
    (also things like Athlon etc optimised ones fit here)
 o  IBM summit kernel
 o  NCR Voyager kernel
 o  SGI visws kernel
 o  Whatever other weirdo subarch pops up.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
