Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263346AbRFCPpI>; Sun, 3 Jun 2001 11:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263447AbRFCPot>; Sun, 3 Jun 2001 11:44:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28384 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263346AbRFCP1G>;
	Sun, 3 Jun 2001 11:27:06 -0400
Date: Sun, 3 Jun 2001 11:27:05 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: symlink_prefix
In-Reply-To: <UTC200106031510.RAA186549.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0106031123440.27673-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Jun 2001 Andries.Brouwer@cwi.nl wrote:

> [My version: keep interface constant, reorganize kernel source
> to do certain things in one place instead of in several places.
> Advantage: treatment becomes uniform and some options that make sense
> for all filesystem types but are available today for some only
> are generalized.
> Your version: invent a new interface, be silent about what happens
> inside the kernel.]

Current interface had grown an impressive collection of warts. Worse
yet, you _can't_ put parsing into generic code. There are filesystems
that have a binary object as 'data'. And there are filesystems that
do post-mount authentication via ioctls on root directory.

