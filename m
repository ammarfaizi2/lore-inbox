Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130600AbRCWLZu>; Fri, 23 Mar 2001 06:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRCWLZa>; Fri, 23 Mar 2001 06:25:30 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:17935 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130600AbRCWLZ2>;
	Fri, 23 Mar 2001 06:25:28 -0500
Date: Fri, 23 Mar 2001 12:24:40 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Amit D Chaudhary <amit@muppetlabs.com>
Cc: lermen@fgan.de, linux-kernel@vger.kernel.org
Subject: Re: /linuxrc query
Message-ID: <20010323122440.S3932@almesberger.net>
In-Reply-To: <3ABAEED2.6020708@muppetlabs.com> <20010323075107.Q3932@almesberger.net> <3ABAF64A.1040106@muppetlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ABAF64A.1040106@muppetlabs.com>; from amit@muppetlabs.com on Thu, Mar 22, 2001 at 11:07:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit D Chaudhary wrote:
> To summarize, pivot_root has been a life saver as the earlier real_root_dev 
> might not have been useful in this case.

The whole old change_root mechanism with real_root_dev is best forgotten
quickly ;-) It's also completely helpless as soon as you fire off some
kernel threads that don't call exit_fs.

> Not using the ramfs limits for now, will do soon.

BTW, if you can't free the RAM disk, you may have to apply
http://icawww1.epfl.ch/~almesber/patches/rdfree

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
