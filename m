Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTJ0MQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTJ0MQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:16:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22283 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261605AbTJ0MQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:16:19 -0500
Date: Mon, 27 Oct 2003 12:16:09 +0000
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Burton Windle <bwindle@fint.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: fsstress causes memory leak in test6, test8
Message-ID: <20031027121609.GA27611@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Burton Windle <bwindle@fint.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.58.0310251842570.371@morpheus> <20031026170241.628069e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031026170241.628069e3.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 05:02:41PM -0800, Andrew Morton wrote:

 > It is not a "leak" as such - the dentries will get shrunk in normal usage
 > (create enough non-dir dentries and the "leaked" directory dentries will
 > get reclaimed).  The really deep directories which fsstress creates
 > demonstrated the bug.

This could explain the random reiserfs oopses/hangs I was seeing several
months back after running fsstress for a day or so. The reiser folks
were scratching their heads, and we even put it down to flaky hardware
or maybe even a CPU bug back then.

 > Given that it took a year for anyone to notice, it's probably best that
 > this not be included for 2.6.0.

I agree in a "lets get 2.6 out the door" sense, but once thats 'out
there' a user-level DoS should be fixed up pretty quickly.
The paranoid could always run 2.6-mm I guess 8-)

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
