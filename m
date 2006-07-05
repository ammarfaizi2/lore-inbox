Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWGEVmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWGEVmh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWGEVmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:42:37 -0400
Received: from pat.uio.no ([129.240.10.4]:7406 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965041AbWGEVmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:42:36 -0400
Subject: Re: ext4 features
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44AC2D9A.7020401@tmr.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>
	 <20060705125956.GA529@fieldses.org>
	 <1152128033.22345.17.camel@lade.trondhjem.org>  <44AC2D9A.7020401@tmr.com>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 17:42:20 -0400
Message-Id: <1152135740.22345.42.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.806, required 12,
	autolearn=disabled, AWL 1.19, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 17:22 -0400, Bill Davidsen wrote:
> Consider the case where the build machine reads source from one network 
> filesystem and write the binary result to another on another machine. If 
> you know that I have the kernel source on a file server, do the compiles 
> on a compute server, and store the binaries on three test machines for 
> evaluation, you might guess this really can happen. Just increasing the 
> timestamp may not solve the problem, unless you have a system call to 
> set timestamp over network f/s, like a high resolution touch.

If you are running 'touch' manually on all your files, you can always
arrange to set the timestamp to something more recent. You don't
normally need a high resolution version of utimes() (and SuSv3 won't
provide you with one).

Cheers,
  Trond

