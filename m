Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUESAE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUESAE2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 20:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbUESAE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 20:04:28 -0400
Received: from janus.foobazco.org ([198.144.194.226]:9344 "EHLO
	mail.foobazco.org") by vger.kernel.org with ESMTP id S262138AbUESAE0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 20:04:26 -0400
Date: Tue, 18 May 2004 17:04:25 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Sparc doesn't build without input support / can't turn off VTs
Message-ID: <20040519000425.GA7865@foobazco.org>
References: <20040518232720.GO5289@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040518232720.GO5289@earth.li>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 12:27:20AM +0100, Jonathan McDowell wrote:

> Tried to build 2.6.6 for my Sparc LX today, which runs headless. Turned
> off all the input support and it failed to build - VT support couldn't
> be disabled and this needs input support it seems.

Correct.  Your patch is probably ok, but it doesn't solve the problem
the right way.  We really need to source the generic configuration
files, which would give us CONFIG_EMBEDDED, which in turn would allow
disabling VT (and INPUT).

I have patches that do virtually all of this for sparc and sparc64;
however, there is a great deal of work needed to include all the
driver configs before that part can go in.  Specifically, every driver
needs to have reasonable dependencies, which requires working with the
maintainers to verify that the deps I have are right.  If you'd like
to pick this up and get it done, please reply to me privately and I'll
give you what you need.

-- 
Keith M Wesolowski
