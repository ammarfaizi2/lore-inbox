Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275278AbRJJKeP>; Wed, 10 Oct 2001 06:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275288AbRJJKeF>; Wed, 10 Oct 2001 06:34:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58768 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275278AbRJJKeB>;
	Wed, 10 Oct 2001 06:34:01 -0400
Date: Wed, 10 Oct 2001 06:34:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: BALBIR SINGH <balbir.singh@wipro.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] register_blkdev and unregister_blkdev
In-Reply-To: <3BC4219F.6020604@wipro.com>
Message-ID: <Pine.GSO.4.21.0110100633300.17790-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Oct 2001, BALBIR SINGH wrote:

> I was looking at the code for register_blkdev and unregister_blkdev. I 
> found that no
> locking (spinlocks) are used to protect the blkdevs struture in these 
> functions. I suspect
> we have not seen a problem till now since

... they are only called under BKL; ditto for lookups in the tables they
(de-)populate.

