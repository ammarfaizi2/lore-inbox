Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288756AbSAIUne>; Wed, 9 Jan 2002 15:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289014AbSAIUnY>; Wed, 9 Jan 2002 15:43:24 -0500
Received: from [216.151.155.108] ([216.151.155.108]:29963 "EHLO
	varsoon.denali.to") by vger.kernel.org with ESMTP
	id <S288756AbSAIUnL>; Wed, 9 Jan 2002 15:43:11 -0500
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, felix-dietlibc@fefe.de
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <200201092005.g09K5OL28043@snark.thyrsus.com>
From: Doug McNaught <doug@wireboard.com>
Date: 09 Jan 2002 15:43:00 -0500
In-Reply-To: "Eric S. Raymond"'s message of "Wed, 9 Jan 2002 15:05:24 -0500"
Message-ID: <m3n0zn6ysr.fsf@varsoon.denali.to>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@snark.thyrsus.com> writes:

> greg k-h:
> >What does everyone else need/want there?
> 
> dmidecode, so the init script can dump a DMI report in a known
> location such as /var/run/dmi.  
> 
> I want this for autoconfiguration purposes.  If I can have it, I
> won't need /proc/dmi.

Why can't this happen inside the regular startup scripts?  They know
where to put such files; the kernel-level stuff doesn't--I can't think
of any current situation where the kernel writes to an arbitrary file
in the filesystem as it boots.  Sure, /var/run is in the FHS, but that
doesn't mean every system will have it.

IMHO, since /var/run/dmi is not needed by any stage of the kernel
boot, it should be created in the regular startup scripts (invoked by
init(8)). 

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
