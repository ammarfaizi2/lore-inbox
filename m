Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVDRMfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVDRMfB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVDRMfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:35:01 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:30668 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262057AbVDRMe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:34:59 -0400
Date: Mon, 18 Apr 2005 14:34:57 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: E1000 - page allocation failure - saga continues :(
Message-ID: <20050418123457.GF26030@mail.muni.cz>
References: <20050414214828.GB9591@mail.muni.cz> <4263A3B7.6010702@univ-nantes.fr> <20050418122202.GE26030@mail.muni.cz> <4263A70F.5060409@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4263A70F.5060409@univ-nantes.fr>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 02:24:47PM +0200, Yann Dupont wrote:
> >I know that kernel 2.6.6-bk4 works. So were there some memory manager changes
> >since 2.6.6? If so it looks like there are some bugs. 
> >On the other hand, ethernet driver should not allocate much memory but rather
> >drop packets.
> >
> >Btw, are you using some TCP tweaks? E.g. I have default TCP window size 1MB.
> >
> No tweaking at all. No jumbo frames.

There were assumptions that it is XFS related. Are you using XFS on that box?

I'm able to deterministically produce this error:
on XFS partition store a file from network using multiple threads. If file size
is bigger then total memory, then it fails after major part of memory is used
for a file cache.

-- 
Luká¹ Hejtmánek
