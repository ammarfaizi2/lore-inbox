Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161168AbWJDPG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbWJDPG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWJDPG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:06:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62907 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161168AbWJDPG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:06:57 -0400
Date: Wed, 4 Oct 2006 08:06:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: akpm@osdl.org, reinette.chatre@linux.intel.com,
       linux-kernel@vger.kernel.org, inaky@linux.intel.com
Subject: Re: [PATCH] bitmap: bitmap_parse takes a kernel buffer instead of a
 user buffer
Message-Id: <20061004080637.0bd19042.pj@sgi.com>
In-Reply-To: <20061004145524.GA24335@tsunami.ccur.com>
References: <200610030816.27941.reinette.chatre@linux.intel.com>
	<20061003163936.d8e26629.akpm@osdl.org>
	<20061004141405.GA22833@tsunami.ccur.com>
	<20061004072746.8e4b97a0.pj@sgi.com>
	<20061004145524.GA24335@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe wrote:
> I guess I am a sucker for no-transient-buffer (bufferless?)

Ah - that explains Joe's preference for putting the actual implementing
code in the user version - it gets to pull in the user string one
char at a time, avoiding a malloc'd buffer.

I tend to make more coding mistakes that way, so have gotten in the
habit of keeping my scanning code separate from any code required to
get a nice safe local copy of the input that is to be scanned.

I agree with Joe - either way can be made to work - author's
discretion.  Just be sure to impose that sanity limit.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
