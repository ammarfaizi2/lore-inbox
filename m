Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270501AbTHLPqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270515AbTHLPqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:46:53 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:3537 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S270501AbTHLPqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:46:49 -0400
Date: Tue, 12 Aug 2003 16:46:16 +0100
From: Dave Jones <davej@redhat.com>
To: Brandon Stewart <rbrandonstewart@yahoo.com>
Cc: linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Requested FAQ addition - Mandrake and partial-i686 platforms
Message-ID: <20030812154616.GA6919@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Brandon Stewart <rbrandonstewart@yahoo.com>,
	linux kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F38FE5B.1030102@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F38FE5B.1030102@yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 10:48:59AM -0400, Brandon Stewart wrote:
 > Apparently, there is an issue with glibc on versions less than 2.3.1-15 
 > (and maybe others), where it mistakenly treats CPUs as full i686 
 > compliant when they only execute a subset of the i686 instructions. For 
 > example, the VIA C3 supports pretty much everything i686 except CMOV, 
 > yet the broken versions of glibc will detect it as fully i686 compliant.

It's actually a problem that gcc assumes 686 = 686+cmov. The glibc
isn't broken, its just compiled for gcc's view of what 686 is.

 > From someone who emailed me privately, this apparently affects K6-III 
 > as well. Possibly other Cyrix or AMD CPUs are affected, though I don't 
 > have a complete list.

No. K6-III is a family 5 processor, so should get built for 586.

 > There are three possible workarounds:
 > 1) Upgrade glibc to a working version. I haven't done this myself, so I 
 > don't know if the bug has been fixed yet. But it would be the best solution.

Its not a glibc bug.

 > 2) Remove i686 libraries from glibc. This can be done by 'mv /lib/i686 
 > /lib/i686.invalid'. This is what I did, and it works. While some 
 > performance is lost, it's not noticeable, especially given that the 
 > stock Mandrake kernel is i386 compatible, and so has limited optimization.

This is the best of the bunch, and is the same solution debian users
were using for some time a while back when someone made a '686' version
of libssl.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
