Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVJIBBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVJIBBm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 21:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVJIBBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 21:01:42 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:18471 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932199AbVJIBBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 21:01:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=l5l/zRJ5CknluRZ4RbbqfSTkLzVMJcTrmBBQiHTUi/JmTfbDteVPwz1jHH3WAPXEQih4n0a/nbI/0NqHdlYc0pC94VAcLCw6k6UNzp+sCleVpUNB6pD2TSe0uC6E0N9NZEO3hviyOowuSpbj5tsGubRlz3t3H7YrRSPRlNISxOo=
Date: Sun, 9 Oct 2005 05:13:15 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] gfp flags annotations
Message-ID: <20051009011315.GA7682@mipter.zuzino.mipt.ru>
References: <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk> <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2005 at 04:34:36PM -0700, Linus Torvalds wrote:
> On Thu, 6 Oct 2005, Al Viro wrote:
> > a) typedef unsigned int __nocast gfp_t;
>
> Btw, since you did a typedef, any reason why it isn't marked __bitwise
> too? It would seem that all valid uses of it are bit tests with predefined
> values, ie a __bitwise restriction would seem very natural, no?

See [*] in Al's RFC.

The amount of endian warnings on allmodconfig is in >10K range. gfp_t
ones would simply be lost in noise.

