Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSHAXBz>; Thu, 1 Aug 2002 19:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSHAXBz>; Thu, 1 Aug 2002 19:01:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14739 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317308AbSHAXBy>;
	Thu, 1 Aug 2002 19:01:54 -0400
Date: Thu, 1 Aug 2002 19:05:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: martin@dalecki.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: IDE from current bk tree, UDMA and two channels...
In-Reply-To: <CF309A2B3C@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0208011903120.12627-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, Petr Vandrovec wrote:
 
> Normal DOS partition, with 512 byte block size, as this is 512B block
> device, at least I believed to it until now. As start=63, it apparently
> also handles 1024B requests on odd address (I believe that sfdisk -d dumps
> start 0-based).
> 
> # partition table of /dev/hdc
> unit: sectors
> 
> /dev/hdc1 : start=       63, size=12685617, Id=83, bootable

Blacklist time.  That, or decrementing size to 12675616, depending on whether
you want that last half-Kb or not.

