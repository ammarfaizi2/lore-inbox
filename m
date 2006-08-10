Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161172AbWHJLLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbWHJLLF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWHJLLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:11:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:4750 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161166AbWHJLLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:11:03 -0400
Date: Thu, 10 Aug 2006 13:05:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
In-Reply-To: <20060809234019.c8a730e3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0608101302270.6762@scrub.home>
References: <1155172843.3161.81.camel@localhost.localdomain>
 <20060809234019.c8a730e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Aug 2006, Andrew Morton wrote:

> That also being said...  does a 32-bit sector_t make any sense on a
> 48-bit-blocknumber filesystem?  I'd have thought that we'd just make ext4
> depend on 64-bit sector_t and be done with it.

Is this really necessary? There are a few features, which would make ext4 
also interesting at the low end (e.g. extents). Storing 64bit values on 
disk is fine, but they should be converted to native values as soon as 
possible.

bye, Roman
