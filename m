Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbSK1WmN>; Thu, 28 Nov 2002 17:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266809AbSK1WmN>; Thu, 28 Nov 2002 17:42:13 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:59469 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S266810AbSK1WmL>;
	Thu, 28 Nov 2002 17:42:11 -0500
Date: Thu, 28 Nov 2002 23:49:30 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Theodore Ts'o" <tytso@mit.edu>, Clemmitt Sigler <siglercm@jrt.me.vt.edu>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Alan Cox <Alan.Cox@linux.org>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
Message-ID: <20021128224930.GA5861@win.tue.nl>
References: <20021126024739.GA11903@think.thunk.org> <Pine.LNX.4.33L2.0211261042290.2368-100000@jrt.me.vt.edu> <20021127125547.GA7903@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021127125547.GA7903@think.thunk.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 07:55:48AM -0500, Theodore Ts'o wrote:

> Ah, ha.  I think I know what happened.
> 
> What version of e2fsprogs were you using?  If it was 1.28, that would
> explain what you saw.  There was a fencepost error that could corrupt
> directories when it was optimizing/rehashing them.  This bug was fixed
> in in the next version, which was rushed out the door as a result of
> this bug.  Fortunately, 1.28 didn't get adopted by any distro's as far
> as I know

Hmm. On a recently installed SuSE 8.1 machine:

% rpm -qf `which e2fsck`
e2fsprogs-1.28-18

(maybe the -18 contains the fix?)
