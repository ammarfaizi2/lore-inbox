Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262628AbTCIVJZ>; Sun, 9 Mar 2003 16:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262629AbTCIVJX>; Sun, 9 Mar 2003 16:09:23 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:18698 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262628AbTCIVJV>;
	Sun, 9 Mar 2003 16:09:21 -0500
Date: Sun, 9 Mar 2003 22:19:59 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: joe briggs <jbriggs@briggsmedia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patching the kernel
Message-ID: <20030309211959.GB18087@mars.ravnborg.org>
Mail-Followup-To: joe briggs <jbriggs@briggsmedia.com>,
	linux-kernel@vger.kernel.org
References: <200303091711.21652.jbriggs@briggsmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303091711.21652.jbriggs@briggsmedia.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 05:11:21PM -0500, joe briggs wrote:
> My apologies for this question that is so basic to all of you, but can any of 
> you please point me toward a howto or instructions for exactly how to 'patch 
> a kernel'?  For example, at kernel.org, the latest stable kernel is 2.4.20, 
> and is actually a patch.  I currently use 2.4.19 under Debian and routinely 
> rebuild & install it no problem.  If I download a kernel 'patch', do I apply 
> it to the entire directory, or the compiled kernel, etc.?  Thanks so much.

Did you read README in the top-level directory of your kernel src?
It is wise to run
$ cp .config ../saved-config
$ make mrproper   <= this one deletes all .o files etc.
$ cp ../saved-config .config
$ make oldconfig dep bzImage modules
after patching the kernel

Did not build a 2.4.* kernel for a while, but the README should provide
all the details.

	Sam

