Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261503AbSIZUd2>; Thu, 26 Sep 2002 16:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbSIZUd2>; Thu, 26 Sep 2002 16:33:28 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:22795 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261503AbSIZUd1>;
	Thu, 26 Sep 2002 16:33:27 -0400
Date: Thu, 26 Sep 2002 13:37:16 -0700
From: Greg KH <greg@kroah.com>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] accessfs v0.5 ported to LSM - 1/2
Message-ID: <20020926203716.GA7048@kroah.com>
References: <878z1rpfb4.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878z1rpfb4.fsf@goat.bogus.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 05:39:43PM +0200, Olaf Dietsche wrote:
> Hi,
> 
> Accessfs is a new file system to control access to system resources.
> For further information see the help text.
> 
> Changes:
> - ported to LSM
> - support capabilities
> - merged ipv4/ipv6 into ip
> 
> This part (1/2) adds a hook to LSM to enable control based on the port
> number.

I like this, it looks quite nice.

You might want to provide a patch against the development LSM tree
(available at lsm.immunix.org) as that tree already has a lot of ip_*
hooks that have not been submitted to the networking group yet.  If you
do this, I would be glad to add this patch to the LSM tree, which will
keep you from having to do the forward port for all new kernel versions
that come out, if you want.  A number of other security related projects
are already in this tree (SELinux, DTE, LIDS, and others.)

thanks,

greg k-h
