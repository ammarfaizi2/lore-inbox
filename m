Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131128AbRCGWls>; Wed, 7 Mar 2001 17:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131129AbRCGWlj>; Wed, 7 Mar 2001 17:41:39 -0500
Received: from niwot.scd.ucar.edu ([128.117.8.223]:59031 "EHLO
	niwot.scd.ucar.edu") by vger.kernel.org with ESMTP
	id <S131128AbRCGWld>; Wed, 7 Mar 2001 17:41:33 -0500
Date: Wed, 7 Mar 2001 15:41:01 -0700
From: Craig Ruff <cruff@ucar.edu>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
Message-ID: <20010307154101.A1206@bells.scd.ucar.edu>
In-Reply-To: <20010307150506.A1046@bells.scd.ucar.edu> <Pine.LNX.4.10.10103071430351.19253-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.10.10103071430351.19253-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Mar 07, 2001 at 02:35:56PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 02:35:56PM -0800, Andre Hedrick wrote:
> So basically you are pointing out that there is now a sequencer reject in
> linux?  Because this used to effect and wipe drives, but you are showing
> that Linux now does scsi commands check for execution on the /dev/sdxx?

Nope, there is a "sequencer reject" is not present.  SCSI drives do not store
sensitive, driver controller private, information in a user accessible
location.

Now, it may be possible to really mess up a drive with the write buffer
command to attempt to download new firmware.  One hopes that the
manufacturers include some sanity checking to prevent short firmware
writes, bad checksum, etc from rendering the drive useless.

Typically what happens is that the user confuses a partition table overwrite
with the drive having been rendered useless.  Of course, there is always
a chance for firmware bugs, but I've never been bit by one.
