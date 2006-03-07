Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWCGE64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWCGE64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 23:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWCGE64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 23:58:56 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:36813 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751025AbWCGE6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 23:58:55 -0500
Date: Mon, 6 Mar 2006 20:58:35 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com
Subject: Re: Ocfs2 performance bugs of doom
Message-ID: <20060307045835.GF27280@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <4408C2E8.4010600@google.com> <20060303233617.51718c8e.akpm@osdl.org> <440B9035.1070404@google.com> <20060306025800.GA27280@ca-server1.us.oracle.com> <440BC1C6.1000606@google.com> <20060306195135.GB27280@ca-server1.us.oracle.com> <p733bhvgc7f.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p733bhvgc7f.fsf@verdi.suse.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 04:34:12AM +0100, Andi Kleen wrote:
> Did you actually do some statistics how long the hash chains are? 
> Just increasing hash tables blindly has other bad side effects, like
> increasing cache misses.
Yep, the gory details are at:

http://oss.oracle.com/~mfasheh/lock_distribution.csv

This measure was taken about 18,000 locks into a kernel untar. The only
change was that I switched things to only hash the last 18 characters of
lock resource names.

In short things aren't so bad that a larger hash table wouldn't help. We've
definitely got some peaks however. Our in-house laboratory of mathematicians
(read: Bill Irwin) is checking out methods by which we can smooth things out
a bit more :)
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
