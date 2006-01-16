Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWAPWWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWAPWWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWAPWWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:22:53 -0500
Received: from ns.suse.de ([195.135.220.2]:42883 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751202AbWAPWWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:22:53 -0500
From: Andi Kleen <ak@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 0/3] changes about Call Trace:
Date: Mon, 16 Jan 2006 23:22:36 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060116121611.GA539@miraclelinux.com> <200601161322.12209.ak@suse.de> <20060116134109.GA6707@miraclelinux.com>
In-Reply-To: <20060116134109.GA6707@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601162322.36979.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 January 2006 14:41, Akinobu Mita wrote:
> On Mon, Jan 16, 2006 at 01:22:11PM +0100, Andi Kleen wrote:
> > On Monday 16 January 2006 13:16, Akinobu Mita wrote:
> > > If I'm missing something, please let me know.
> > > 
> > > a) On x86-64 we get different Call Trace format than other architectures
> > >    when we get oops or press SysRq-t:
> > > 
> > >    <ffffffffa008ef6c>{:jbd:kjournald+1030}
> > > 
> > >    There is a architecture independent function print_symbol().
> > >    How about using it on x86-64? But it changes to:
> > > 
> > >    [<ffffffffa008ef6c>] kjournald+0x406/0x578 [jbd]
> > 
> > The x86-64 format is more compact.
> 
> How about this update?
> 
> 1/3: change from "[<...>]" to  "<...>".
> 2/3: change the format of offset from hexadecimal to decimal in.

Can you please repost it in a fresh thread? I lost track of what was
the latest patch.

In general if you can make the call trace more compact without
losing information it's ok for me. Better wrapping sounds like
a promising approach.

-Andi
