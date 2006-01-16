Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWAPNlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWAPNlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 08:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWAPNlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 08:41:08 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:22584 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750739AbWAPNlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 08:41:07 -0500
Date: Mon, 16 Jan 2006 22:41:09 +0900
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] changes about Call Trace:
Message-ID: <20060116134109.GA6707@miraclelinux.com>
References: <20060116121611.GA539@miraclelinux.com> <200601161322.12209.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601161322.12209.ak@suse.de>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 01:22:11PM +0100, Andi Kleen wrote:
> On Monday 16 January 2006 13:16, Akinobu Mita wrote:
> > If I'm missing something, please let me know.
> > 
> > a) On x86-64 we get different Call Trace format than other architectures
> >    when we get oops or press SysRq-t:
> > 
> >    <ffffffffa008ef6c>{:jbd:kjournald+1030}
> > 
> >    There is a architecture independent function print_symbol().
> >    How about using it on x86-64? But it changes to:
> > 
> >    [<ffffffffa008ef6c>] kjournald+0x406/0x578 [jbd]
> 
> The x86-64 format is more compact.

How about this update?

1/3: change from "[<...>]" to  "<...>".
2/3: change the format of offset from hexadecimal to decimal in.

