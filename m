Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUHBQMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUHBQMO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266591AbUHBQMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:12:14 -0400
Received: from holomorphy.com ([207.189.100.168]:34221 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266578AbUHBQMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:12:13 -0400
Date: Mon, 2 Aug 2004 09:12:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
Message-ID: <20040802161207.GH2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org> <20040802135240.GF2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802135240.GF2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 06:52:40AM -0700, William Lee Irwin III wrote:
> Speaking of cleanups, I've got a little something.
>  65 files changed, 274 insertions(+), 1076 deletions(-)
> This mass slaughter of duplicated code is a cleanup of /proc/profile
> that consolidates code across all arches and privatizes private state.
> Compiletested on x86-64. Prior incarnations of earlier cleanups this
> is based on were runtime tested on ia32, x86-64, sparc64, and alpha.
> The purpose of these cleanups in their prior incarnations has been for
> use as a preparatory cleanup for profiling other kinds of events in
> /proc/profile's buffer (or similar buffers). There has recently been a
> need to discover which codepaths were responsible for leaking inodes
> that were leaking that similar cleanups in combination with some slab
> profiling hooks are being used to instrument.

Successfully runtime-tested on x86-64 in combination with patches to
unrelated areas of the kernel (poisoning certain portions of certain
data structures that should not need to be allocated and should never
be accessed). Zero userspace-visible changes to output or interface.


-- wli
