Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161366AbWAMFPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161366AbWAMFPk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 00:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161363AbWAMFPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 00:15:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62173 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161309AbWAMFPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 00:15:38 -0500
Subject: Re: [PATCH] [5/6] Handle TIF_RESTORE_SIGMASK for i386
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: sgrubb@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com, dhowells@redhat.com
In-Reply-To: <20060112205451.392c0c5c.akpm@osdl.org>
References: <1136923488.3435.78.camel@localhost.localdomain>
	 <1136924357.3435.107.camel@localhost.localdomain>
	 <20060112195950.60188acf.akpm@osdl.org>
	 <1137126606.3085.44.camel@localhost.localdomain>
	 <20060112205451.392c0c5c.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Jan 2006 05:11:05 +0000
Message-Id: <1137129065.3085.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 20:54 -0800, Andrew Morton wrote:
> Yes, that dmesg output seems to have been truncated.
> 
> Here's another one, better:
> 
> 	http://www.zip.com.au/~akpm/linux/patches/stuff/dmesg
> 
> Note that I have /bin/zsh in /etc/passwd.

Indeed better; thanks. Will ponder and attempt to reproduce here on
i386.

> That looks like the crap I saw scrolling past.  How come it came out on the
> console after a few minutes?

Not sure. That probably means the kernel has decided that your userspace
audit dæmon has gone AWOL.... and indeed it seems to be stuck on a
futex. I know of no reason why it should be doing that -- Steve?

-- 
dwmw2

