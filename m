Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWGXI4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWGXI4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 04:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWGXI4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 04:56:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60891 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751017AbWGXI4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 04:56:51 -0400
Date: Mon, 24 Jul 2006 01:55:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org, akpm@osdl.org,
       jeff@garzik.org, adobriyan@gmail.com, vlobanov@speakeasy.net,
       getshorty_@hotmail.com, pwil3058@bigpond.net.au, mb@bu3sch.de,
       penberg@cs.helsinki.fi, stefanr@s5r6.in-berlin.de, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 4)
Message-Id: <20060724015549.c4294b05.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0607231805210.26413@yvahk01.tjqt.qr>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	<1153669750.44c39a7607a30@portal.student.luth.se>
	<Pine.LNX.4.61.0607231805210.26413@yvahk01.tjqt.qr>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan wrote:
> Can someone please tell me what advantage 'define true true' is going to
> bring, besides than being able to '#ifdef true'?

I think Jeff's replies to this are a tad confusing.  He seems
to be answering in part with the broader point of the value of
increased type checking using enums, and not focusing on the
specific reason these two defines of true and false are there.

As best as I can tell, these two odd looking defines are just to
suppress #define alternative's to our enum based false and true
constructs, in the likely case that the alternatives are guarded
with the usual #ifndef logic.

In other words, their advantage is basically what you said, being
able to '#ifdef true' (or #ifndef).

As I recommend in another subthread, these two defines need a comment.

And since there is only one "#ifndef true" left in the entire kernel
source tree, in drivers/media/video/cpia2/cpia2.h, I would think it
would be better to just remove those lines from cpia2.h, and drop
these two odd looking defines.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
