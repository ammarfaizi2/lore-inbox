Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVAPNXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVAPNXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 08:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVAPNXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 08:23:47 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:15884 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S262500AbVAPNXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:23:44 -0500
Date: Sun, 16 Jan 2005 14:23:40 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Matt Mackall <mpm@selenic.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: short read from /dev/urandom
Message-ID: <20050116132340.GA8163@pclin040.win.tue.nl>
References: <41E7509E.4030802@redhat.com> <20050116024446.GA3867@waste.org> <41E9E65F.1030100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E9E65F.1030100@redhat.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: pastinakel.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 07:58:23PM -0800, Ulrich Drepper wrote:

> Matt Mackall wrote:
> >_Neither_ case mentions signals and the "and will return as many bytes
> >as requested" is clearly just a restatement of "does not have this
> >limit". Whoever copied this comment to the manpage was a bit sloppy
> >and dropped the first clause rather than the second:
> 
> It still means the documented API says there are no short reads.

No. It says that /dev/urandom "contains" an unlimited amount
of bits - you can read as many bits from there as you want,
while /dev/random "contains" a limited amount of information -
you can exhaust it.

That is information about the device. There is no suggestion at all
about some special property that would guarantee that the normal
read() system call has special behavior in connection with /dev/urandom.

There is no special documented API. Now that this misunderstanding
occurred I suppose a clarifying sentence will be added.
Nothing special with /dev/urandom.

Applications that make special assumptions are broken.

Andries
