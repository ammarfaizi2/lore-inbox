Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbTB0Tf3>; Thu, 27 Feb 2003 14:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbTB0Tf3>; Thu, 27 Feb 2003 14:35:29 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:53252 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S265865AbTB0Tf2>; Thu, 27 Feb 2003 14:35:28 -0500
Date: Thu, 27 Feb 2003 14:44:40 -0500
From: Ben Collins <bcollins@debian.org>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com,
       ak@suse.de, davem@redhat.com, arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
Message-ID: <20030227194440.GM21100@phunnypharm.org>
References: <20030226222606.GA9144@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226222606.GA9144@elf.ucw.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 11:26:06PM +0100, Pavel Machek wrote:
> Hi!
> 
> This is next version of ioctl32 consolidation. At one point it
> compiled on x86-64 and sparc64. I'm not 100% sure it still does...
> 
> Could you try to apply it on your architecture, fix whatever breakage
> it causes, and submit patch back to me?
> 
> ia64 has very different ioctl32 emulation (and very short). What is
> going on there? Also not all architectures knew about
> register_ioctl32_translation. Ouch.

FYI, whatever changes you made to sparc64's ioctl32.c broke. Doesn't
appear that any of the 32bit ioctl's are registered, so the system never
boots to usermode fully (since it's completely 32bit).

Not sure I'll be able to look into the reason, but it's probably simple.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
