Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273950AbRIRVwL>; Tue, 18 Sep 2001 17:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273952AbRIRVwB>; Tue, 18 Sep 2001 17:52:01 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:8834 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273950AbRIRVvt>;
	Tue, 18 Sep 2001 17:51:49 -0400
Date: Tue, 18 Sep 2001 17:52:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Matt D. Robinson" <yakker@aparity.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Request for new block_device_operations function pointer
In-Reply-To: <Pine.LNX.4.30.0109181436110.27510-100000@nakedeye.aparity.com>
Message-ID: <Pine.GSO.4.21.0109181748350.27538-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Matt D. Robinson wrote:

> This would allow projects such as LKCD to use a specific dump
> device associated to a block device driver.  This dump driver
> writes data out directly to disk at a specific offset.  The

... while submit_bh()... writes data out directly to disk at a specific
offset.  Amazing, isn't it?

Notice that you _will_ need to deal with IO in driver's queue, no matter
how you implement the thing.  submit_bh() already does it.

