Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUBOX7g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 18:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUBOX7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 18:59:36 -0500
Received: from holomorphy.com ([199.26.172.102]:28547 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265255AbUBOX7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 18:59:34 -0500
Date: Sun, 15 Feb 2004 15:59:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Schwebel <robert@schwebel.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Cross Compiling
Message-ID: <20040215235927.GC631@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Schwebel <robert@schwebel.de>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <402D9567.B5044EFE@ou.edu> <20040214142157.GA9398@MAIL.13thfloor.at> <20040215232810.GK549@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040215232810.GK549@pengutronix.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 03:21:57PM +0100, Herbert Poetzl wrote:
>> thanks for the info, I read/tested that one too, some time
>> ago, but decided against this approach, as it builds the
>> glibc, which I do not need for the kernel toolchain at all
>> and I didn't want to bother with another source that won't
>> compile on arch xy ... maybe the wrong decision? I don't 
>> know ...

On Mon, Feb 16, 2004 at 12:28:11AM +0100, Robert Schwebel wrote:
> you might also want to have a look at the idea behind PTXdist (see
> http://www.pengutronix.de/software/ptxdist_en.html) which is also able
> to build toolchains and do all the necessary tweaking, without building
> a glibc (just only run 'make xchain-gccstage1' to get a compiler without
> glibc). It follows the same approach for the patch repositories like Dan
> and we are syncing heavily.
> The whole toolchain building is a huge mess at the moment.  

(a) The idiot thing was screwed wrt. binutils when the things were
	prefixed with e.g. sparc64-linux-gnu-$PROG; I managed to decipher
	where the paths were and just patch in the names of the crossutils.
(b) The stuff produced broken kernels; I had to resort to native builds
	anyway (which far from ideal, since it target violates host/target
	separation), and lost money getting a second of its kind to repair
	that state of affairs.

-- wli
