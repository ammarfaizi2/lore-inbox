Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRCPBJq>; Thu, 15 Mar 2001 20:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129364AbRCPBJg>; Thu, 15 Mar 2001 20:09:36 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:48120 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129359AbRCPBJY>;
	Thu, 15 Mar 2001 20:09:24 -0500
Date: Thu, 15 Mar 2001 20:08:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: adilger@turbolinux.com, lars@larsshack.org, mikpe@csd.uu.se,
        amnet@amnet-comp.com, hch@caldera.de, jjasen1@umbc.edu,
        linux-kernel@vger.kernel.org, util-linux@math.uio.no
Subject: Re: [util-linux] Re: magic device renumbering was -- Re: Linux
 2.4.2ac20
In-Reply-To: <UTC200103152331.AAA2159588.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0103151951050.10709-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Mar 2001 Andries.Brouwer@cwi.nl wrote:

> Design a Linux partition table format, where a partition descriptor
> has fields start, end, fstype, fslabel, and the whole disk has a vollabel.
> Put it in sector 0-N for an all-Linux disk, and in sectors pointed at
> by a classical DOS-type partition table entry when the disk is shared.

Yes, but for $DEITY sake, let's make it text. Something along the lines of
Linux partition table\n(START,LENGTH,TYPE(,LABEL)?n)*End\0
START: NUMBER
LENGTH: NUMBER
TYPE: [^,\n\0]+
LABEL: [^\n\0]+
NUMBER: <see strtoul(3)>

Will make life much simpler when one needs to recover the bloody thing...

