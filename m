Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267193AbUHRPaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267193AbUHRPaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 11:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUHRPae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 11:30:34 -0400
Received: from relay.pair.com ([209.68.1.20]:64782 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267193AbUHRPaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 11:30:17 -0400
X-pair-Authenticated: 68.42.66.6
Subject: Re: Help with mapping memory into kernel space?
From: Daniel Gryniewicz <dang@fprintf.net>
To: Brian McGrew <Brian@doubledimension.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E6456D527ABC5B4DBD1119A9FB461E3501E00B@constellation.doubledimension.com>
References: <E6456D527ABC5B4DBD1119A9FB461E3501E00B@constellation.doubledimension.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Aug 2004 11:30:15 -0400
Message-Id: <1092843015.14961.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 22:39 -0700, Brian McGrew wrote:
> Good day All:
> 

<snip>

> The overall problem is that the more system memory we install,
> the fewer IBB's we can use.  For instance, 256MB lets us use
> four IBB's; 512MB lets us use three IBB's and so on.  Basicly,
> the kernel blows up trying to map memory.  Each IBB has two
> banks of 64MB of RAM on them which we try and memmap to system
> memory for speed of addressing.  So essentaily, we're sending
> out four camera systems with only 256MB of memory which is only
> about one quarter of what we need.

On x86, the kernel has 1 GiB of address space.  Try the 2G/2G split
patches, or the 4G/4G patches, either one of which should increase your
kernel address space enough to map both memory and your buffers.

Daniel
