Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131547AbRCXC73>; Fri, 23 Mar 2001 21:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131550AbRCXC7T>; Fri, 23 Mar 2001 21:59:19 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:56010 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131547AbRCXC7E>; Fri, 23 Mar 2001 21:59:04 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Fwd: Re: [PATCH] Prevent OOM from killing init
To: linux-kernel@vger.kernel.org
Date: Fri, 23 Mar 2001 21:58:22 -0500
Organization: me
User-Agent: KNode/0.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20010324025823.69BCD5A@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


,--------------- Forwarded message (begin)

 Subject: Re: [PATCH] Prevent OOM from killing init
 From: Jonathan Morton <chromi@cyberspace.org>
 Date: Fri, 23 Mar 2001 20:45:43 -0500

 >Hmm...  "if ( freemem < (size_of_mallocing_process / 20) ) fail_to_allocate;"

Not sure this is that reasonable on a 4G box... 800M is a big chunk...

Why not base this on the vm's free goal.  If I remember correctly it tries to keep one
second of pages ready for allocating.  If memory is so tight that a second's worth of
memory does not exist.  Note that I mean memory free in main memory and swap.

Think your malloc patch along with UID weighting (1-99 protected, 100-999 endangered, 
1000+ open season - with poaching expected if there is no choise) will make help oom 
processing.

Ed Tomlinson

