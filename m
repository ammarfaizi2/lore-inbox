Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbTBQFkr>; Mon, 17 Feb 2003 00:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbTBQFkr>; Mon, 17 Feb 2003 00:40:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18195 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266851AbTBQFkq>;
	Mon, 17 Feb 2003 00:40:46 -0500
Message-ID: <3E507819.6000700@pobox.com>
Date: Mon, 17 Feb 2003 00:50:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] klibc for 2.5.59 bk
References: <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> I did some work on integrating klibc into kbuild now. I used your patch as 
> guide line, though I started from scratch with klibc-0.77. The build 
> should work fine (reminder: "make KBUILD_VERBOSE=0 ..." will give you much 

woo hoo!  Thanks much.  I was sorta hoping you would step in and help 
out with the kbuild issues ;-)


> To do something more useful than "hello world", I actually moved some part 
> of finding / mounting the final root system into userspace, though only 
> conditional on CONFIG_INITRAMFS.

FWIW, this should be ok for testing, but not a merge...  we need to have 
a single "do_mounts" code flow, not two code paths that are selected 
with a switch.

That's why I see a lot of little klibc binaries, especially initially. 
Moving piece-by-piece from do_mounts.c (and other places) to userspace 
takes longer, but really maximizes both stability and testing of new code.

	Jeff



