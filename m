Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291253AbSAaTxx>; Thu, 31 Jan 2002 14:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291256AbSAaTxo>; Thu, 31 Jan 2002 14:53:44 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:21199 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291253AbSAaTxe>; Thu, 31 Jan 2002 14:53:34 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [linux-lvm] Re: [lvm-devel] [ANNOUNCE] LVM reimplementation ready for
 beta testing
To: lvm-devel@sistina.com
Cc: Jim McDonald <Jim@mcdee.net>, Andreas Dilger <adilger@turbolabs.com>,
        linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
        lvm-devel@sistina.com, evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OFBCE93B66.F7B9C14E-ON85256B52.006B8AB3@raleigh.ibm.com>
From: "Steve Pratt" <slpratt@us.ibm.com>
Date: Thu, 31 Jan 2002 13:52:29 -0600
X-MIMETrack: Serialize by Router on D04NM202/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/31/2002 02:53:07 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber wrote:
>On Wed, Jan 30, 2002 at 10:03:40PM +0000, Jim McDonald wrote:
>> Also, does/where does this fit in with EVMS?

>EVMS differs from us in that they seem to be trying to move the whole
>application into the kernel,

No, not really.  We only put in the kernel the things that make sense to be
in the kernel, discovery logic, ioctl support, I/O path.  All configuration
is handled in user space.

> whereas we've taken the opposite route
>and stripped down the kernel side to just provide services.

Then why does snapshot.c in device mapper have a read_metadata function
which populates the exception table from on disk metadata?  Seems like you
agree with us that having metadata knowledge in the kernel is a GOOD thing.

>This is fine, I think there's room for both projects.  But it is worth
>noting that EVMS could be changed to use device-mapper for it's low
>level functionality.  That way they could take advantage of the cool
>work we're doing with snapshots and pvmove, and we could take
>advantage of having more eyes on the core driver.

Since device_mapper does not support in kernel discovery, and EVMS relies
on this, it would be very difficult to change EVMS to use device_mapper.
Besides, EVMS already has all the capabilities provided by device mapper,
including a complete LVM1 compatibility package.

>LVM2 may not seem that exciting initially, since the first release is
>just concentrating on reproducing LVM1 functionality.  But a lot of
>the reason for this rewrite is to enable us to add in the new features
>that we want (such as a transaction based disk format).  It's on this
>new feature list that we'll be mainly competing with EVMS.

Why compete, come on over and help us :-)

Steve


EVMS Development - http://www.sf.net/projects/evms
Linux Technology Center - IBM Corporation
(512) 838-9763  EMAIL: SLPratt@US.IBM.COM

