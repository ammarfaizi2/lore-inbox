Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270359AbRHMSK1>; Mon, 13 Aug 2001 14:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270360AbRHMSKH>; Mon, 13 Aug 2001 14:10:07 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:58350 "EHLO
	dukat.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S270359AbRHMSKE>; Mon, 13 Aug 2001 14:10:04 -0400
Date: Mon, 13 Aug 2001 18:56:29 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: ext3-users@redhat.com
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.6
Message-ID: <20010813185629.M20408@redhat.com>
In-Reply-To: <3B75DE86.EEDFAFFB@zip.com.au> <20010812043841.B8413@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010812043841.B8413@bacchus.dhis.org>; from ralf@uni-koblenz.de on Sun, Aug 12, 2001 at 04:38:41AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 12, 2001 at 04:38:41AM +0200, Ralf Baechle wrote:
> On Sat, Aug 11, 2001 at 06:40:22PM -0700, Andrew Morton wrote:
> 
> > - ext3 has for a long time had developer code which allows the target device
> >   to be turned read-only at the disk device driver level a certain number
> >   of jiffies after the fs was mounted.  This is to allow scripted testing
> >   of crash recovery.  This facility has been extended to support two devices;
> >   one for the filesystem and one for the external journal device.
> 
> Would this facility also be able to deal with parts of a device becoming
> read-only unexpectedly?  Some of the disks I have in RAIDs have the
> nice habit of disabling write access when overheating.  That's an
> interesting failure scenario in a RAID system.

No, that particular part of the ext3 patch is only there for testing
--- it forces a single device readonly to simulate a crash.  It adds
no ability to deal cleanly with a device unexpectedly going readonly
on its own. 

Cheers,
 Stephen
