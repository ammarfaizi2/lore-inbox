Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264889AbSKEQCQ>; Tue, 5 Nov 2002 11:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264890AbSKEQCQ>; Tue, 5 Nov 2002 11:02:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44304 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264889AbSKEQCF>; Tue, 5 Nov 2002 11:02:05 -0500
Date: Tue, 5 Nov 2002 08:08:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: "David S. Miller" <davem@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.46
In-Reply-To: <Pine.LNX.4.44.0211050958470.20254-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0211050806151.2762-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Nov 2002, Kai Germaschewski wrote:
> 
> > Why not just hexdump the thing into an array of char foo.c file,
> > then compile that.
> 
> Well, I wouldn't think there's any toolchain which doesn't support the 
> current way when given the right flags, so that looks faster and cleaner 
> to me.

Especially since we expect the array to be potentially megabytes in the 
end (especially if somebody wants to make a bootable CD using this), and 
at least traditional gcc's would do horrible O(n^2) things with big 
initialized arrays. 

Much better to just tell the tools it is a blob.

		Linus

