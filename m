Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUIOQ6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUIOQ6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUIOQ57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:57:59 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:33802 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S266821AbUIOQ4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:56:13 -0400
Date: Wed, 15 Sep 2004 17:56:08 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
Message-ID: <20040915165608.GC24892@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 09:30:42AM -0700, Linus Torvalds wrote:

 > So right now the current snapshots (and 2.6.9-rc2) have this enabled, and
 > some drivers will be _very_ noisy when compiled. Most of the regular ones
 > are fine, so maybe people haven't even noticed it that much, but some of
 > them were using things like "u32" to store MMIO pointers, and are
 > generally extremely broken on anything but an x86.  We'll hopefully get
 > around to fixing them up eventually, but in the meantime this should at 
 > least explain the background for some of the new noise people may see.

For the curious, 6MB of sparse output is generated from a make allmodconfig
right now. (http://www.codemonkey.org.uk/junk/2.6.9-rc2-warnings.txt)

You can filter out just the __iomem warnings by grepping for asn:2

		Dave

