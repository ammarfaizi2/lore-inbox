Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288435AbSADA5N>; Thu, 3 Jan 2002 19:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288434AbSADA5D>; Thu, 3 Jan 2002 19:57:03 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:34018 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288435AbSADA4x>;
	Thu, 3 Jan 2002 19:56:53 -0500
Date: Thu, 3 Jan 2002 19:56:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Joerg Schilling <schilling@fokus.gmd.de>, anderson@metrolink.com,
        hch@caldera.de, lsb-discuss@lists.linuxbase.org,
        lsb-spec@lists.linuxbase.org, linux-kernel@vger.kernel.org
Subject: Re: LSB1.1: /proc/cpuinfo
In-Reply-To: <20020103190219.B27938@thyrsus.com>
Message-ID: <Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Jan 2002, Eric S. Raymond wrote:

> Well, hell.  If the "/proc is a blight on the face of the planet" ranting that
> I've been hearing is just about the *name* /proc, then let's separate the
> name issue from the content issue.

It's more than just a name.
	a) granularity.  Current "all or nothing" policy in procfs has
a lot of obvious problems.
	b) tree layout policy (lack thereof, to be precise).
	c) horribly bad layout of many, many files.  Any file exported by
kernel should be treated as user-visible API.  As it is, common mentality
is "it's a common dump; anything goes here".  Inconsistent across
architectures for no good reason, inconsistent across kernel versions,
just plain stupid, choke-full of buffer overruns...

Fixing these problems will _hurt_.  Badly.  We have to do it, but it
won't be fast and it certainly won't happen overnight.

