Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbTAXBjb>; Thu, 23 Jan 2003 20:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267498AbTAXBjb>; Thu, 23 Jan 2003 20:39:31 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:29705 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S267455AbTAXBja>; Thu, 23 Jan 2003 20:39:30 -0500
Date: Thu, 23 Jan 2003 20:48:15 -0500
From: Ben Collins <bcollins@debian.org>
To: desrt <desrt@desrt.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ieee1394: Node 01:1023 has non-standard ROM format (0 quads), cannot parse
Message-ID: <20030124014815.GB4524@hopper.phunnypharm.org>
References: <1043372135.1442.7.camel@nothing.desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043372135.1442.7.camel@nothing.desrt.ca>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 08:35:35PM -0500, desrt wrote:
> Hello.
> 
> I just got a new plextor combo (read dvd, write cd) drive and installed
> it into my firewire drive enclosure.  The CD-ROM drive that was in there
> previously was working fine.  I am using an Audigy as my firewire
> controller.
> 
> Now, on attach/power on/modprobe ohci1394/etc I get this message:
> 
> ieee1394: Node 01:1023 has non-standard ROM format (0 quads), cannot
> parse

Every 1394 device is required to have a Config ROM directory. The
directory has to be _atleast_ 4 quads for basic information to be
extracted and allow the subsystem to use the device. Without even 1 quad
it cannot even verify the magic '1', '3', '9', '4' quad at the start of
it.

If one cdrom works in the enclosure and another doesn't, then I suspect
something is weird with the enclosure's detection of the device you
placed in it. Are you sure that the master/slave jumpers are set
correctly for the enclosure? Anything else it needs?

> If anybody has experienced this before, has any ideas, would like
> information about the problem or even knows of a better forum to direct
> this question to, your help would be greatly appreciated.  Please CC: me
> a copy of your reply as I am not on the list.

http://www.linux1394.org/ has a compatibility list. You can also email
linux1394-devel@lists.sf.net.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
