Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVETSNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVETSNu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 14:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVETSNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 14:13:50 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:5863 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261525AbVETSNs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 14:13:48 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Thread and process dentifiers (CPU affinity, kill)
Date: Fri, 20 May 2005 18:13:48 +0000 (UTC)
Organization: Cistron
Message-ID: <d6l9cs$l1t$1@news.cistron.nl>
References: <428CD458.6010203@free.fr> <20050520125511.GC23488@csclub.uwaterloo.ca> <428DF95E.2070703@free.fr> <20050520165307.GG23488@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1116612828 21565 194.109.0.112 (20 May 2005 18:13:48 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050520165307.GG23488@csclub.uwaterloo.ca>,
Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
>On Fri, May 20, 2005 at 04:51:10PM +0200, Olivier Croquette wrote:
>> From the beginning we are talking about the present GNU/Linux systems, 
>> which do already use NTPL in standard. NPTL is no future standard, it is 
>> present standard.
>
>Hmm, I just noticed the page I found about NPTL had 2005 date one place
>and 2002 in another.  Yeah that is what people are using already.
>
>Most current i386 systems do NOT use NPTL yet by default since it only
>works on 2.6 kernels, and even then probably only if glibc was compiled
>that way.

No. On modern systems, glibc contains both LinuxThreads and NPTL.
They have the same ABI. At runtime one of the two is selected,
depending on if the currently running kernel supports NTPL.
You can also force it by setting the LD_ASSUME_KERNEL environment
variable to 2.4 or 2.6.

Mike.

