Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269503AbRHGWdy>; Tue, 7 Aug 2001 18:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270201AbRHGWdi>; Tue, 7 Aug 2001 18:33:38 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:2063 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S269503AbRHGWca>; Tue, 7 Aug 2001 18:32:30 -0400
Message-ID: <20010807235434.B2032@bug.ucw.cz>
Date: Tue, 7 Aug 2001 23:54:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] parser for mount options
In-Reply-To: <Pine.GSO.4.21.0108071227080.18565-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.GSO.4.21.0108071227080.18565-100000@weyl.math.psu.edu>; from Alexander Viro on Tue, Aug 07, 2001 at 01:02:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	Patch applies clean at least to -pre4 and -pre5.  Comments,
> suggestions and flames are welcome.  I hope that it got enough
> filesystems converted to be representative - adfs, autofs, devpts,
> ext2, fat and isofs.

fat and isofs have pretty ugly set of options:

nodots and dotsOK=no are same thing (oops, you've bug there). It would
be nice to have just one name for each function. No need to do
second-guessing in kernel.

> +static match_table_t FAT_tokens = {
> +	{Opt_check_r, "check=relaxed"},
> +	{Opt_check_s, "check=strict"},
> +	{Opt_check_n, "check=normal"},
> +	{Opt_check_r, "check=r"},
> +	{Opt_check_s, "check=s"},
> +	{Opt_check_n, "check=n"},
> +	{Opt_conv_b, "conv=binary"},
> +	{Opt_conv_t, "conv=text"},
> +	{Opt_conv_a, "conv=auto"},
> +	{Opt_conv_b, "conv=b"},
> +	{Opt_conv_t, "conv=t"},
> +	{Opt_conv_a, "conv=a"},
> +	{Opt_dots, "dots"},
> +	{Opt_dots, "dotsOK=yes"},
> +	{Opt_nodots, "nodots"},
> +	{Opt_dots, "dotsOK=no"},
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

here's bug, btw.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
