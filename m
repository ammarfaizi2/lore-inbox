Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130791AbRCJBBM>; Fri, 9 Mar 2001 20:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130794AbRCJBBC>; Fri, 9 Mar 2001 20:01:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54417 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130791AbRCJBA5>;
	Fri, 9 Mar 2001 20:00:57 -0500
Date: Fri, 9 Mar 2001 20:00:15 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: LA Walsh <law@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <3AA9653B.B691C8F2@sgi.com>
Message-ID: <Pine.GSO.4.21.0103091958030.17677-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Mar 2001, LA Walsh wrote:

> Could someone enlighten me as to the purpose of this field in the
> dentry struct?  There is no elucidating comment in the header for this
> particular field and the name/type only indicate it is pointing to
> a list of vfsmounts.  Can a dentry belong to more than one vfsmount?

Yes.

> If I have a 'dentry' and simply want to determine what the absolute
> path from root is, in the 'd_path' macro, would I use 'rootmnt' of my
> current->fs as the 'vfsmount' as well?

No such thing. The same fs may be present in many places. Please,
describe the situation - where do you get that dentry from?
							Cheers,
								Al

