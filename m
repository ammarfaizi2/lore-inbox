Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136176AbRD0TWa>; Fri, 27 Apr 2001 15:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136178AbRD0TWV>; Fri, 27 Apr 2001 15:22:21 -0400
Received: from a1a90191.sympatico.bconnected.net ([209.53.18.14]:54990 "EHLO
	a1a90191.sympatico.bconnected.net") by vger.kernel.org with ESMTP
	id <S136176AbRD0TWC>; Fri, 27 Apr 2001 15:22:02 -0400
Date: Fri, 27 Apr 2001 12:22:00 -0700
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010427122200.A16947@cm.nu>
In-Reply-To: <20010427095840.A701@suse.cz> <Pine.LNX.4.21.0104270951270.2067-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.21.0104270951270.2067-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Apr 27, 2001 at 09:52:19AM -0700
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2001 at 09:52:19AM -0700, Linus Torvalds wrote:
> 
> On Fri, 27 Apr 2001, Vojtech Pavlik wrote:
> > 
> > Actually this is done quite often, even on mounted fs's:
> > 
> > hdparm -t /dev/hda
> 
> Note that this one happens to be ok.
> 
> The buffer cache is "virtual" in the sense that /dev/hda is a completely
> separate name-space from /dev/hda1, even if there is some physical
> overlap.

Wouldn't something like "hdparm -t /dev/md0" trigger it
though.  It is the same device as gets mounted as md
devices aren't partitioned.

Shane


-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
