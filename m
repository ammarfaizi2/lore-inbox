Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUDPXe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbUDPXe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:34:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52360 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263457AbUDPXey
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:34:54 -0400
Date: Sat, 17 Apr 2004 00:34:52 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       bfennema@falcon.csc.calpoly.edu
Subject: Re: Fix UDF-FS potentially dereferencing null
Message-ID: <20040416233452.GK24997@parcelfarce.linux.theplanet.co.uk>
References: <20040416214104.GT20937@redhat.com> <20040416220014.GI24997@parcelfarce.linux.theplanet.co.uk> <40806880.1030007@pobox.com> <20040416231823.GZ20937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416231823.GZ20937@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 12:18:23AM +0100, Dave Jones wrote:
> On Fri, Apr 16, 2004 at 07:13:04PM -0400, Jeff Garzik wrote:
>  > >Check in question is a BS - it never gets NULL passed as dir.
>  > 
>  > Yes, it looks like a lot of these NULL checks caught can be fixed simply 
>  > by removing bogus and/or redundant checks.
> 
> And there's a *lot* of them. Those half dozen or so patches earlier were
> results of just a quick random skim of the list the coverity folks came up with.
> 
> It'll take a lot of effort to 'fix' them all, and given the non-severity
> of a lot of them, I'm not convinced it's worth the effort.

We really ought to kill just-in-case checks like that - they only obfuscate
the code _and_ hide bugs.  The thing we must *not* do is "closing" the
items in that list by adding meaningless precautions of that sort.
