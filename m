Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131350AbRCNNeB>; Wed, 14 Mar 2001 08:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131351AbRCNNdm>; Wed, 14 Mar 2001 08:33:42 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:39694 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131350AbRCNNdV>;
	Wed, 14 Mar 2001 08:33:21 -0500
Date: Wed, 14 Mar 2001 14:31:57 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Anthony <anthony@magix.com.sg>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        autofs@linux.kernel.org
Subject: Re: Should mount --bind not follow symlinks?
Message-ID: <20010314143157.B27572@pcep-jamie.cern.ch>
In-Reply-To: <Pine.GSO.4.21.0103120835390.25792-100000@weyl.math.psu.edu> <3AACED42.39DF0A24@magix.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AACED42.39DF0A24@magix.com.sg>; from anthony@magix.com.sg on Tue, Mar 13, 2001 at 12:37:38AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony wrote:
> Perhaps I'm blissfully unaware of all sorts of vile
> race conditions, but why can't the *automounter* chase
> the symlinks even if mount shouldn't?  Or am I missing
> a neater solution?

The automounter could indeed chase those symlinks.

Also, if the automounter creates a symlink in /opt anyway, and the link
subsequently works (as you said), then it shouldn't be returning "No
such file or directory" the first time.

In other words the latter behaviour looks like a bug in the automounter,
and the former is a feature which could be added but isn't needed for
your application.

-- Jamie
