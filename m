Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261976AbRETOp2>; Sun, 20 May 2001 10:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261977AbRETOpS>; Sun, 20 May 2001 10:45:18 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:992 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261976AbRETOpI>;
	Sun, 20 May 2001 10:45:08 -0400
Date: Sun, 20 May 2001 10:45:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
In-Reply-To: <3B07D519.5184BFA@alsa-project.org>
Message-ID: <Pine.GSO.4.21.0105201034090.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Abramo Bagnara wrote:

> > It may have several. Which one?
> 
> Can you explain better this?

Example: console. You want to be able to pass font changes. I'm
less than sure that putting them on the same channel as, e.g.,
keyboard mapping changes is a good idea. We can do it, but I don't
see why it's natural thing to do. Moreover, you already have
/dev/vcs<n> and /dev/vcsa<n>. Can you explain what's the difference
between them (per-VC channels) and keyboard mapping (also per-VC)?

Face it, we _already_ have more than one side band.

Moreover, we have channels that are not tied to a particular device -
they are for a group of them. Example: setting timings for IDE controller.
Sure, we can just say "open /dev/hda instead of /dev/hda5", but then we
are back to the "find related file" problem you tried to avoid.

