Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318602AbSIKJjS>; Wed, 11 Sep 2002 05:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318607AbSIKJjS>; Wed, 11 Sep 2002 05:39:18 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:16044 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318602AbSIKJjR>;
	Wed, 11 Sep 2002 05:39:17 -0400
Date: Wed, 11 Sep 2002 05:44:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions gets name wrong for IDE discs
In-Reply-To: <15742.55241.543312.523055@wombat.chubb.wattle.id.au>
Message-ID: <Pine.GSO.4.21.0209110539060.9260-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Sep 2002, Peter Chubb wrote:

> 
> The `all of disc' name in /proc/partitions is coming out as `<NULL>'
> instead of /dev/hda or similar when not using devfs, in current BK.
> 
> major minor  #blocks  name
> 
>    9     0  240120512 <NULL>
>    3     0    4202415 <NULL>
>    3     1     979933 hda1
>    3     2     979965 hda2
>    3     3    2241067 hda3
>   22     0  120060864 <NULL>
>   22     1  120059887 hdc1
>   22    64  120060864 <NULL>
>   22    65  120060830 hdd1

Can't reproduce it.

% cat /proc/partitions
major minor  #blocks  name

  45     0   39082680 pda
  45     1    8389048 pda1
  45     2     524664 pda2
  11     0    1048575 sr0
   3     0   29300040 hda
   3     1      16033 hda1
   3     2    1052257 hda2
   3     3     104422 hda3
   3     4          1 hda4
   3     5      56196 hda5
   3     6     248976 hda6
   3     7     248976 hda7
   3     8     248976 hda8
   3     9     586341 hda9
   3    10   14201428 hda10
   3    64   14668416 hdb
   3    65    8389048 hdb1
%

2.5.34-BK, no devfs in sight...

