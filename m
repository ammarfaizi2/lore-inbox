Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTFGVhl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 17:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbTFGVhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 17:37:41 -0400
Received: from holomorphy.com ([66.224.33.161]:54216 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263777AbTFGVhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 17:37:40 -0400
Date: Sat, 7 Jun 2003 14:49:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maximum swap space?
Message-ID: <20030607214950.GI8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <ltptlqb72n.fsf@colina.demon.co.uk> <33435.4.64.196.31.1055008200.squirrel@www.osdl.org> <bbtmaq$r03$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbtmaq$r03$1@cesium.transmeta.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <33435.4.64.196.31.1055008200.squirrel@www.osdl.org>
By author:    "Randy.Dunlap" <rddunlap@osdl.org>
In newsgroup: linux.dev.kernel
>> Linux 2.4.10 and later, and Linux 2.5 support any combination of swap
>> files or swap devices to a maximum number of 32 of them.  Prior to Linux
>> 2.4.10, the limit was any combination of 8 swap files or swap devices.  On
>> x86 architecture systems, each of these swap areas has a limit of 2 GiB.

On Sat, Jun 07, 2003 at 02:43:54PM -0700, H. Peter Anvin wrote:
> 2 GiB is getting a bit tight, especially with tmpfs, ust like the
> previous limits of 16 MiB and 128 MiB were getting tight at various
> points, and it's annoying to have to make multiple partitions.
> tmpfs is a good thing -- in my experience even if it is stored
> primarily on disk it is much faster for temp files than any other
> filesystem, simply because it never has to worry about consistency.
> This means it's entirely reasonable to have a "farm" machine with a
> 40 GiB tmpfs used for everything except the OS itself.

The 2GB limit is 100% userspace; distros are already shipping the
mkswap(8) fixes (both RH & UL anyway).


-- wli
