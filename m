Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264639AbSJ3JtB>; Wed, 30 Oct 2002 04:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264642AbSJ3JtB>; Wed, 30 Oct 2002 04:49:01 -0500
Received: from c-66-176-164-150.se.client2.attbi.com ([66.176.164.150]:43420
	"EHLO schizo.psychosis.com") by vger.kernel.org with ESMTP
	id <S264639AbSJ3JtA>; Wed, 30 Oct 2002 04:49:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: andersen@codepoet.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Date: Wed, 30 Oct 2002 04:55:21 -0500
User-Agent: KMail/1.4.2
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <200210272017.56147.landley@trommello.org> <200210300322.17933.dcinege@psychosis.com> <20021030085149.GA7919@codepoet.org>
In-Reply-To: <20021030085149.GA7919@codepoet.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210300455.21691.dcinege@psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 October 2002 3:51, Erik Andersen wrote:

Erik,

> Both formats are simple.  But cpio is simpler.

untar runs about 5K...same as 'un-cpio'. No differece there.
But not from userland. Tar is used en masse, cpio isn't.
It's the only reason to use tar over cpio...I feel it's a
good one.

Erik

#1 I'll be reviewing initramfs and adding loading images from
the kernel support. I don't deny it's a good thing to have.

#2 My main complaint is Jeff said if initramfs goes in
initrd comes out. initrd should not come out. Let me clarify: the
abilty of the bootloader to load images/archives for the kernel
to extract should not come out.

My patch is the best of both because, it re-writes initrd
properly within a sane framework. (Not to mention I scrubed the hell
out of do_mounts.)

If you want to get rid of all the backwards compatible stuff
(IE identifing and loading raw images to /dev/ram0,
pivoting to /initrd) that's fine with me. The code is layed out now
so I can litterally cut it out 10K of that junk in 30 seconds.
Better yet I can ifdef it for the poor souls that still need it.

Dave

