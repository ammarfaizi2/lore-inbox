Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272263AbTHKFiy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272281AbTHKFix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:38:53 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:39557 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272263AbTHKFiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:38:50 -0400
Date: Mon, 11 Aug 2003 06:38:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com, chip@pobox.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030811053830.GM10446@mail.jlokier.co.uk>
References: <1060488233.780.65.camel@cube> <20030810072945.GA14038@alpha.home.local> <20030811045531.GH10446@mail.jlokier.co.uk> <20030811052659.GA28640@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811052659.GA28640@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> It may well be when you use it in boolean constructs. The following functions
> return exactly the same result with different code :
> 
> int test1(int u, int v, int x, int y) {
>    return (u > v) || (x > y);
> }
> 
> int test2(int u, int v, int x, int y) {
>    return !!(u > v) | !!(x > y);
> }

Yes, it sounds familiar.  Although my code was not as contrived :) it
was from a real program.  Also, try "x != 0" instead of "!!x" and see
if you get different results.

-- Jamie
