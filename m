Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312828AbSCVUNf>; Fri, 22 Mar 2002 15:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312827AbSCVUNZ>; Fri, 22 Mar 2002 15:13:25 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4299 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312826AbSCVUNV>;
	Fri, 22 Mar 2002 15:13:21 -0500
Date: Fri, 22 Mar 2002 15:13:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rakesh Tiwari <rakeshtiwari@attbi.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19(xx) file unmapping on abort
In-Reply-To: <3C9B8DE5.7FF84BF3@attbi.com>
Message-ID: <Pine.GSO.4.21.0203221512170.1714-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Mar 2002, Rakesh Tiwari wrote:

> 
> I call msync() at various points in the program where data in the pages
> is known to be in good condition. At the abnormal program termination, I
> am not really sure if data in pages is valid or not.....

If you have a shared mapping it can be written to disk at any moment, so
you can't rely on that happening only at the moment of msync().

