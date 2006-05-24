Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWEXEIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWEXEIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWEXEIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:08:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:13941 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932221AbWEXEID convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:08:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cV16d3J4v2nLcQquM94+U9lsixQ6qd4nK9ZjIuFSmB1urp2Cqw14kBAEtMGa4NaHCUOcjgT6/eU9tpmUa2MDJkKrlVyBiGDUEqrZT6C3gF3jpix4zM74NRVxAMj3YH30yb0hQ8LRGEhTFO6e9cpylgyPzfrof7k55CP+Xphfgeo=
Message-ID: <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
Date: Wed, 24 May 2006 14:08:02 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605232338.54177.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <1148379089.25255.9.camel@localhost.localdomain>
	 <200605232338.54177.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I am currently looking for some information or help in making the Framebuffer
> devices use DRM and setting up a userspace system that interfaces with the
> DRM backed framebuffer device to provide full 2D and 3D acceleration of all
> supported features and *userspace* emulation of the unsupported stuff.
>

The first step is to provide some sort of communication between the
DRM and fb drivers so they know the other one exists,

previous attempts at this by myself have come apart in the device
model which just plainly cannot support this without adding a couple
of dirty hacks,

The two attempts I've done, were using a vgaclass device from Alan
Cox, and also adding a lowlevel driver for the radeon, hotplug became
my major issue each time, discussions last year at Kernel Summit were
had, but the results however never surfaced, I'm intending to go to KS
this year and actually try and get Greg-KH to fix the device model for
what we need as opposed to hacking the crap out of it.

All the other designs and stuff people have mentioned have all been
discussed to death before, people seem to love discussing graphics,
but no-one seems to care about fixing it properly, in nice incremental
steps that doesn't break older systems. The current systems are very
very fixable, however there always seem to be lots of people who want
to re-write it because it is a) ugly in their opinion b) don't care
about backwards compat.

Dave.
