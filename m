Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263218AbSJTQpg>; Sun, 20 Oct 2002 12:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263232AbSJTQpg>; Sun, 20 Oct 2002 12:45:36 -0400
Received: from cs.columbia.edu ([128.59.16.20]:14284 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S263218AbSJTQpf>;
	Sun, 20 Oct 2002 12:45:35 -0400
Subject: first step in making chroot nestable?
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1035132676.2173.15.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2 (Preview Release)
Date: 20 Oct 2002 12:51:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in looking through the code, it seems the follow_dotdot() function in
fs/namei.c is the ultimate part of how the kernel keeps programs jailed
into a chroot.

basically (very basic) what it appears to do is

if (place we chrooted == current place)
{
	we're at the root
} otherwise we aren't

If we would have a linked list of chroot points, and whenever we hit one
of those points in a walk, we treat it as a root, wouldn't this chain
any fd's one brought into a chroot to the original root of that fd.

yes, there are other things that would have to be taken care of to make
a chroot jail more secure, but this should be an easy thing, correct? or
am I missing more.

thanks,

shaya

	

