Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUDABAL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 20:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUDABAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 20:00:11 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:64029 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261735AbUDABAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 20:00:06 -0500
Date: Wed, 31 Mar 2004 16:58:30 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, wli@holomorphy.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040331165830.3b7e0aec.pj@sgi.com>
In-Reply-To: <1080779931.9787.3.camel@arrakis>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1080779931.9787.3.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	2 small changes to include/linux/mask.h:

Yup - good ones.

I'm just starting to rebuild this set of patches, with:

  1) The various little changes posted so far and your updates
  2) The "don't generate non-zero unused bits" strengthening of
     lib/bitmap.c's postconditions a clearly distinct member of the
     patch set, with a comment explaining the bitmap/bitop "model",
  3) Renaming cpus_raw => cpus_addr (it's current name),
  4) Whatever else I see in passing, and
  5) An actually test of it this time, on an ia64.

Then I should make this update visible and seek further buy in from
any potentially affected arch maintainers.

Much of the above represents what I've learned from Bill Irwin's
detailed review of this so far.  I trust Bill will speak up if I
misconstrued one of his recommendations.

Question:

Matthew, Bill, Andrew, anyone - how should I present the next version of
this set of 22 give or take patches in this set?  Another new set of 22
lkml posts; one reply or 22 replies to the some post on the existing
threads; tarballs; web site URL; ...  The possibilities are varied.

My inclination would be just as I did it the first time - some 22
rapid fire separate posts.  But I'm game for considering alternatives.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
