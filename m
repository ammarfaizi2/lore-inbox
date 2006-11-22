Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967027AbWKVDZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967027AbWKVDZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 22:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967029AbWKVDZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 22:25:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33237 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S967027AbWKVDZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 22:25:22 -0500
Date: Tue, 21 Nov 2006 22:25:12 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Message-ID: <20061122032512.GE533@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org> <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com> <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org> <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com> <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com> <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org> <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com> <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com> <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com> <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 06:36:39PM -0800, Linus Torvalds wrote:
 > 
 > 
 > On Wed, 22 Nov 2006, Jesper Juhl wrote:
 > > 
 > > So it *seems* to be somehow related to running low on RAM and swap
 > > starting to be used.
 > 
 > Does it happen if you just do some simple "use all memory" script, eg run 
 > a few copies of
 > 
 > 	#define SIZE (100<<20)
 > 
 > 	char *buf = malloc(SIZE);
 > 	memset(buf, SIZE, 0);
 > 	sleep(100);
 > 
 > on your box?

ITYM...

memset(buf, 0, SIZE);

		Dave

-- 
http://www.codemonkey.org.uk
