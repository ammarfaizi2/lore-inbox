Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTJRWv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 18:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbTJRWv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 18:51:29 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:11783 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261903AbTJRWv2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 18:51:28 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] initrd with devfs enabled (Re: initrd and 2.6.0-test8)
Date: Sun, 19 Oct 2003 00:46:04 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <3F916A0C.10800@comcast.net> <200310182356.04346.arekm@pld-linux.org> <20031018221143.GI7665@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20031018221143.GI7665@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310190046.04897.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 of October 2003 00:11, viro@parcelfarce.linux.theplanet.co.uk 
wrote:

> > I've tried to create initramfs image with unpacking initrd image,
[...]
> > It doesn't work that way unfortunately (test8 with your patch).
>
> Yes and no - it *is* unpacked, but currently we have no code that would
> try to run something from initramfs.  If you want to play with that -
> add something like run_init_process("/init"); right before the call of
> prepare_namespace() in init/main.c (and be ready to have /init on
> initramfs do the rest, obvoiusly).
I see. So right now external initramfs image seems to be unusable (probably 
the same when compiling it in the kernel) right now. The quesion arrives - 
what was the reason to not put run_init_process("/linuxrc") by default there 
(like it is for initrd) ?

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

