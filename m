Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbUBLEKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 23:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266261AbUBLEKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 23:10:55 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:5796 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S266258AbUBLEKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 23:10:54 -0500
Date: Thu, 12 Feb 2004 05:10:10 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: [Patch] Netlink BUG() on AMD64
Message-ID: <20040212051009.A16112@fi.muni.cz>
References: <20040205183604.N26559@fi.muni.cz> <20040211181113.GA2849@fi.muni.cz> <20040212.034537.11291491.yoshfuji@linux-ipv6.org> <20040212.035825.101259632.yoshfuji@linux-ipv6.org> <20040211194909.0ab130cc.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040211194909.0ab130cc.davem@redhat.com>; from davem@redhat.com on Wed, Feb 11, 2004 at 07:49:09PM -0800
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
: Both fixes applied, thanks guys.
: 
: I was tempted to make skb_put()'s second argument signed, but I'm in no mood
: to audit the entire tree for that :-)

	I have grep'd the kernel for all occurences of rtattr_failure
and nlmsg_failure, and there are no more skb_put()s than those two
(hmm, legacy protocols which no-one uses, such as Decnet or IPv4 :-).
However, the same problem is in 2.4, so please push these fixes to
Marcelo as well.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
