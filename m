Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbTB0URf>; Thu, 27 Feb 2003 15:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTB0URf>; Thu, 27 Feb 2003 15:17:35 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:30725 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S266868AbTB0URe>; Thu, 27 Feb 2003 15:17:34 -0500
Date: Thu, 27 Feb 2003 15:27:39 -0500
From: Ben Collins <bcollins@debian.org>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com,
       ak@suse.de, davem@redhat.com, arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
Message-ID: <20030227202739.GO21100@phunnypharm.org>
References: <20030226222606.GA9144@elf.ucw.cz> <20030227195135.GN21100@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227195135.GN21100@phunnypharm.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 02:51:35PM -0500, Ben Collins wrote:
> On Wed, Feb 26, 2003 at 11:26:06PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > This is next version of ioctl32 consolidation. At one point it
> > compiled on x86-64 and sparc64. I'm not 100% sure it still does...
> > 
> > Could you try to apply it on your architecture, fix whatever breakage
> > it causes, and submit patch back to me?
> > 
> > ia64 has very different ioctl32 emulation (and very short). What is
> > going on there? Also not all architectures knew about
> > register_ioctl32_translation. Ouch.
> 
> Ok, so it was simple. Do you mind a patch that applies over yours?
> 

Here it is. Sparc64's macros for ioctl32's assumed that cmd was u_int
instead of u_long. This look ok to you, Dave?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
