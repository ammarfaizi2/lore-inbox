Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRCWOJJ>; Fri, 23 Mar 2001 09:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130824AbRCWOI7>; Fri, 23 Mar 2001 09:08:59 -0500
Received: from t2.redhat.com ([199.183.24.243]:45305 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S130820AbRCWOIs>; Fri, 23 Mar 2001 09:08:48 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3ABAF64A.1040106@muppetlabs.com> 
In-Reply-To: <3ABAF64A.1040106@muppetlabs.com>  <3ABAEED2.6020708@muppetlabs.com> <20010323075107.Q3932@almesberger.net> 
To: Amit D Chaudhary <amit@muppetlabs.com>
Cc: Werner Almesberger <Werner.Almesberger@epfl.ch>, lermen@fgan.de,
        linux-kernel@vger.kernel.org
Subject: Re: /linuxrc query 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 23 Mar 2001 14:07:51 +0000
Message-ID: <9118.985356471@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


amit@muppetlabs.com said:
>  Also as a note, what we are doing is keeping our rootfs on flash as a
> tar.gz and  reading it and mounting it on a ramfs in the /linuxrc
> before doing a pivot_root.  To summarize, pivot_root has been a life
> saver as the earlier real_root_dev  might not have been useful in this
> case. Not using the ramfs limits for now, will do soon.

If you're concerned about memory usage - why untar the whole of your root
filesystem into a ramfs? My preferred solution is to just mount the root
filesystem directly from the flash as cramfs (or JFFS2), with symlinks into a
ramfs for appropriate parts like /tmp and /var.

I suppose the best option is actually to union-mount the ramfs over the 
root, rather than mucking about with symlinks. I just haven't got round to 
doing that yet.

--
dwmw2


