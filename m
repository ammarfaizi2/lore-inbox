Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312183AbSCTVDU>; Wed, 20 Mar 2002 16:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312187AbSCTVDL>; Wed, 20 Mar 2002 16:03:11 -0500
Received: from mailhub.unibe.ch ([130.92.9.52]:48593 "EHLO mailhub.unibe.ch")
	by vger.kernel.org with ESMTP id <S312183AbSCTVDB>;
	Wed, 20 Mar 2002 16:03:01 -0500
Date: Wed, 20 Mar 2002 22:02:58 +0100 (MET)
From: Matthias Scheidegger <mscheid@iam.unibe.ch>
Subject: Re: extending callbacks?
In-Reply-To: <m18z8nw7qk.fsf@frodo.biederman.org>
X-X-Sender: mscheid@speedy
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <Pine.GSO.4.44.0203202132550.12299-100000@speedy>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> The general case requires self modifying code.  Where do you need this in the
> kernel.  For most callbacks the kernel is already passing a fairly generic
> parameter you can use.  So this trick should be unnecessary.

In my case the problem is indeed fairly general, so I can't seem to count on a
generic parameter. Most callbacks do have them, but not all of them.

Anyway, since you agree the general case requires self modifying code I'll do it
that way. Now I just need to know how to make a page executable in a portable
way (get_free_page on i386 already returns executable pages...)

If anyone's interested in the background of this:
I'm writing a kernel module containing an interpreter for the Python language,
which in turn accesses the kernel functions through a wrapper layer. This
makes writing kernel modules in pure Python possible. I know this is rather sick :)


cheers

Matthias

