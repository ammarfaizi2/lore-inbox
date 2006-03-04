Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWCDOF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWCDOF0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 09:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWCDOF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 09:05:26 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:42423 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751157AbWCDOFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 09:05:25 -0500
Date: Sat, 4 Mar 2006 15:01:52 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>, bunk@stusta.de,
       ".geert"@linux-m68k.org, linux-m68k@vger.kernel.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: 2.6.16-rc regression: m68k CONFIG_RMW_INSNS=n compile broken
In-Reply-To: <20060303155913.2e299736.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603041457070.16802@scrub.home>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
 <20060303230149.GB9295@stusta.de> <Pine.LNX.4.64.0603031515321.22647@g5.osdl.org>
 <20060303155913.2e299736.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 3 Mar 2006, Andrew Morton wrote:

> Yes, we now require cmpxchg of all architectures.

Actually I'd prefer if we used atomic_cmpxchg() instead.
The cmpxchg() emulation was never added for a good reason - to keep code 
from assuming it can be used it for userspace synchronisation. Using an 
atomic_t here would probably get at least some attention.

bye, Roman
