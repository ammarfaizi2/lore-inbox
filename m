Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVDJSWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVDJSWn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVDJSWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:22:00 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:6797 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261562AbVDJSTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:19:36 -0400
Date: Sun, 10 Apr 2005 11:19:05 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: tony.luck@intel.com
Cc: torvalds@osdl.org, pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050410111905.53a2f6a1.pj@engr.sgi.com>
In-Reply-To: <200504101200.j3AC0Mu13146@unix-os.sc.intel.com>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<200504101200.j3AC0Mu13146@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony wrote:
> Or maybe the files should be named objects/xx/yy/zzzzzzzzzzzzzzzz?

I tend to size these things with the square root of the number of
leaf nodes.  If I have 2,560,000 leaves (your 10,000 files in each
of 16*16 directories), then I will aim for 1600 directories of
1600 leaves each.

My backup is sized for about this number of leaves, and it uses:

	xxx/xxxzzzzzzzzzzzzzzzz

(I repeat the xxx in the leaf name - easier to code.)

I don't think there is any need for two levels.  There are 4096
different values of three digit hex numbers.  That's ok in one
directory.

The only question would be 'xx' or 'xxx' - two or three digits.

This one is on the cusp in my view - either works.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
