Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319555AbSIHCRW>; Sat, 7 Sep 2002 22:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319559AbSIHCRW>; Sat, 7 Sep 2002 22:17:22 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:30878 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S319555AbSIHCRV>; Sat, 7 Sep 2002 22:17:21 -0400
Date: Sun, 8 Sep 2002 03:21:21 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Daniel Phillips <phillips@arcor.de>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
Message-ID: <20020908032121.A23455@kushida.apsleyroad.org>
References: <20020907192736.A22492@kushida.apsleyroad.org> <Pine.GSO.4.21.0209071544090.23598-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0209071544090.23598-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Sep 07, 2002 at 03:47:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> It is neither safe nor needed.  Please, look at the previous posting again -
> neither variant calls mntput() in ->release().
> 
> Now, __fput() _does_ call mntput() - always.  And yes, if that happens to
> be the final reference - it's OK.

Thanks, that's really nice.

I'd assumed `kern_mount' was similar to mounting a normal filesystem,
but in a non-existent namespace.  Traditionally in unix you can't
unmount a filesystem when its in use, and mounts don't disappear when
the last file being used on them disappears.

But you've rather cutely arranged that these kinds of mount _do_
disappear when the last file being used on them disappears.  Clever, if
a bit disturbing.

-- Jamie

