Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130170AbRCLNlJ>; Mon, 12 Mar 2001 08:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130176AbRCLNlA>; Mon, 12 Mar 2001 08:41:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:35538 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130170AbRCLNks>;
	Mon, 12 Mar 2001 08:40:48 -0500
Date: Mon, 12 Mar 2001 08:40:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Anthony Heading <anthony@magix.com.sg>
cc: linux-kernel@vger.kernel.org
Subject: Re: Should mount --bind not follow symlinks?
In-Reply-To: <3AACA87D.70C740A8@magix.com.sg>
Message-ID: <Pine.GSO.4.21.0103120835390.25792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Mar 2001, Anthony Heading wrote:

> Hi,
>     My automounted dirs have up till now been symlinks, where
> e.g. /opt/perl defaults to automounting /export/opt/perl/LATEST
> which is a symlink.
> 
>    This all worked OK until the 2.4(.2) automounter helpfully tries
> to mount --bind /export/opt/perl/LATEST /opt/perl

Don't mix symlinks with mounts/bindings. Too much PITA and yes, it had
been deliberately prohibited. You _really_ don't want to handle the
broken symlinks and all the realted fun - race-ridden at extreme and
useless.

In automount-like setups you can _replace_ symlinks with bindings.
No need to mix them.
							Cheers,
								Al

