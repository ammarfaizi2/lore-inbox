Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbRF0EYk>; Wed, 27 Jun 2001 00:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbRF0EYT>; Wed, 27 Jun 2001 00:24:19 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:17927 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265244AbRF0EYI>; Wed, 27 Jun 2001 00:24:08 -0400
Message-ID: <3B395FE5.1070208@zytor.com>
Date: Tue, 26 Jun 2001 21:24:05 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot
In-Reply-To: <200106270332.f5R3WxU277042@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:

> 
> Normal users can use an environment provided for them.
> 
> While trying to figure out why the "heyu" program would not
> work on a Red Hat box, I did just this. As root I set up all
> the device files needed, along Debian libraries and the heyu
> executable itself. It was annoying that I couldn't try out
> my chroot environment as a regular user.
> 
> Creating the device files isn't a big deal. It wouldn't be
> hard to write a setuid app to make the few needed devices.
> If we had per-user limits, "mount --bind /dev/zero /foo/zero"
> could be allowed. One way or another, devices can be provided.
> 


Hell no!  This would give the user a way to subvert root or other 
system-provided things by having device nodes or such appear where they 
aren't expected.  NOT GOOD.

	-hpa


