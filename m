Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263281AbSKTXK1>; Wed, 20 Nov 2002 18:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSKTXK1>; Wed, 20 Nov 2002 18:10:27 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:65187 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S263193AbSKTXKX>; Wed, 20 Nov 2002 18:10:23 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Date: Thu, 21 Nov 2002 10:17:21 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15836.6145.203067.371300@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
In-Reply-To: message from Bill Rugolsky Jr. on Wednesday November 20
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
	<20021120085838.A9206@ti19>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 20, brugolsky@telemetry-investments.com wrote:
> On Wed, Nov 20, 2002 at 03:09:18PM +1100, Neil Brown wrote:
> >     u32  feature_map     /* bit map of extra features in superblock */
> 
> Perhaps compat/incompat feature flags, like ext[23]?

I thought about that, but am not sure that it makes sense as there is
much less metadata in a raid array than there is in a filesystem.
I think I am happier to have initial code require feature_map == 0 or
it doesn't get loaded, and if it becomes an issue, get user-space to
clear any 'compatible' flags before passing the device to an 'old'
kernel.

> 
> Also, journal information, such as a journal UUID?

As there is no current code, or serious project that I know of, to add
journalling to md (I have thought about it, but it isn't a priority) I
wouldn't like to pre-empt it at all by defining fields now.  I would
rather that presense-of-a-journal be indicated by a bit in the feature map,
and that would imply uuid was stored in one of the current 'pad'
fields.  I think there is plenty of space.

Thanks,
NeilBrown


> 
> Regards,
> 
> 	Bill Rugolsky
