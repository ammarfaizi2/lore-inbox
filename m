Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWHBCQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWHBCQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWHBCQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:16:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25317 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750740AbWHBCQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:16:19 -0400
Date: Tue, 1 Aug 2006 22:16:17 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: frequent slab corruption (since a long time)
Message-ID: <20060802021617.GH22589@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every so often, I see a slab corruption bug reported against
the Fedora kernels (going back as far as 2.6.11), and it's
still plagueing us.

It seems to have turned up in a number of different scenarios,
which makes it all the more complicated, but the footprint is
always the same. We write ffffffff00000000 to freed memory.
All the example cases seen so far have been on 32-bit x86.

Anyone have any clues where that value could be coming from?

There's a collection of corruption reports at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=160878

		Dave

-- 
http://www.codemonkey.org.uk
