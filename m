Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135839AbRDTRLb>; Fri, 20 Apr 2001 13:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135842AbRDTRLW>; Fri, 20 Apr 2001 13:11:22 -0400
Received: from elektra.higherplane.net ([203.37.52.137]:64698 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S135839AbRDTRLR>; Fri, 20 Apr 2001 13:11:17 -0400
Date: Sat, 21 Apr 2001 03:19:20 +1000
From: john slee <indigoid@higherplane.net>
To: Harald Welte <laforge@gnumonks.org>
Cc: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Documentation of module parameters.
Message-ID: <20010421031920.M10345@higherplane.net>
In-Reply-To: <3ADBB8C9.CC7FD941@nc.rr.com> <p05100b07b7017fc83c2e@[207.213.214.34]> <20010420133722.D2461@tatooine.laforge.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010420133722.D2461@tatooine.laforge.distro.conectiva>; from laforge@gnumonks.org on Fri, Apr 20, 2001 at 01:37:22PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2001 at 01:37:22PM -0300, Harald Welte wrote:
> On Mon, Apr 16, 2001 at 10:07:56PM -0700, Jonathan Lundell wrote:
> > At 11:30 PM -0400 2001-04-16, Chris Kloiber wrote:
> > >I was recently looking for a single location where all the possible
> > >module parameters for the linux kernel was located.
> >
> > Hear him. A DocBook document would be a dandy place for this to get pulled
> > together, too.
> 
> good idea. One could just grab all the MODULE_PARM_DESC out of all sourcefiles,
> look to which module the particular sourcefile belongs (looking into
> Makefile?), and create a Documentation/DocBook/... document out of it.
> 
> Sounds like something doable, only somebody needs to get around doing
> it. Any volunteers?

it sounded like a challenge.  this might help someone who can't be
bothered extracting all the data by hand.  it spits it out in tab
delimited form, as sanely as i could manage in 5 minutes.

j.

-- 
"Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson

--H8ygTp4AXg6deix2
Content-Type: text/x-sh; charset=us-ascii
Content-Disposition: attachment; filename="kernel-module-info.sh"

#!/bin/sh

# john slee <indigoid@higherplane.net>
# Sat Apr 21 03:17:55 EST 2001
# quick and dirty.  run from a kernel source dir somewhere.

find . -name "*.c" | xargs egrep 'MODULE_DESCRIPTION|MODULE_PARM_DESC' \
	| sed '/#undef/d; s/^\.\///; s/[:()]/	/g; s/[";]//g; /MODULE_PARM_DESC/s/,[ ]*/	/; /^[	 ]*$/d'

--H8ygTp4AXg6deix2--
