Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWAPPvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWAPPvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWAPPvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:51:53 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:33344 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751050AbWAPPvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:51:52 -0500
Date: Tue, 17 Jan 2006 00:51:53 +0900
To: Arjan van de Ven <arjan@infradead.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] omit symbol size field in print_symbol()
Message-ID: <20060116155153.GA6628@miraclelinux.com>
References: <20060116121611.GA539@miraclelinux.com> <20060116121834.GD539@miraclelinux.com> <1137422221.3034.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137422221.3034.25.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 03:37:01PM +0100, Arjan van de Ven wrote:
> On Mon, 2006-01-16 at 21:18 +0900, Akinobu Mita wrote:
> > I can't find useful usage for the symbol size in print_symbol().
> > And symbolsize seems to be fixed when vmlinux or modules are compiled.
> > So we can calculate it from vmlinux or modules.
> 
> 
> the use is that you can see if the EIP actually is inside the function,
> or if the decoder is going bonkers. Quite useful feature that...
> 

If it is really useful, should we have it on x86-64 too?
The patches 1/3 and 2/3 will do that.
Andi Kleen doesn't want because The call trace on x86-64 could have more
than one symbol per line, but my patches will print more characters than
now.
