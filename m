Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTJPUo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbTJPUng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 16:43:36 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:24311 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263173AbTJPUnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 16:43:25 -0400
Date: Thu, 16 Oct 2003 14:42:05 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Eli Billauer <eli_billauer@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org,
       David Mosberger-Tang <David.Mosberger@acm.org>
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031016144205.I7000@schatzie.adilger.int>
Mail-Followup-To: Eli Billauer <eli_billauer@users.sourceforge.net>,
	linux-kernel@vger.kernel.org,
	David Mosberger-Tang <David.Mosberger@acm.org>
References: <HbGf.8rL.1@gated-at.bofh.it> <HbQ5.ep.27@gated-at.bofh.it> <Hdyv.2Vd.13@gated-at.bofh.it> <HeE6.4Cc.1@gated-at.bofh.it> <HjaT.3nN.7@gated-at.bofh.it> <Hjkw.3Al.11@gated-at.bofh.it> <ugzng1axel.fsf@panda.mostang.com> <3F8EF17A.2040502@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F8EF17A.2040502@users.sf.net>; from eli_billauer@users.sourceforge.net on Thu, Oct 16, 2003 at 09:28:58PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 16, 2003  21:28 +0200, Eli Billauer wrote:
> Allow me to supply a couple facts about frandom:
> 
> * It's not a "crappy" RNG. Its RC4 origins and the fact, that it has 
> passed tests indicate the opposite. A fast RNG doesn't necessarily mean 
> a bad one. I doubt if any test will tell the difference between frandom 
> and any other good RNG. You're most welcome to try.

The "crappy RNG" being referred to is just some code we implemented to
give us somewhat unique numbers instead of sucking CPU.

> * Frandom is written completely in C. On an i686, gcc compiles the 
> critical part to 26 assembly instructions per byte, and I doubt if any 
> hand assembly would help significantly. The algorithms is clean and 
> simple, and the compiler performs well with it.

This is still more expensive than a hw RNG (which will be about 1 ins
per 4 bytes), so it would be nice to make this arch-specific if possible
(runtime and compile time).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

