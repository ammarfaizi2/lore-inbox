Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263869AbUDUBCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbUDUBCg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 21:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUDUBCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 21:02:35 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:52925 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263869AbUDUBC3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 21:02:29 -0400
Date: Tue, 20 Apr 2004 18:02:26 -0700
From: Andy Isaacson <adi@bitmover.com>
To: Chris Wright <chrisw@osdl.org>, Zack Brown <zbrown@tumblerings.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: matching "Cset exclude" changelog entries to the changelog entries they revert.
Message-ID: <20040421010226.GC27313@bitmover.com>
References: <20040421001236.GA16901@tumblerings.org> <20040420172622.K22989@build.pdx.osdl.net> <20040421003820.GB16901@tumblerings.org> <20040420174147.G21045@build.pdx.osdl.net> <20040421001236.GA16901@tumblerings.org> <20040420172622.K22989@build.pdx.osdl.net> <20040421003820.GB16901@tumblerings.org> <20040421001236.GA16901@tumblerings.org> <20040420172622.K22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420174147.G21045@build.pdx.osdl.net> <20040421003820.GB16901@tumblerings.org> <20040420172622.K22989@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 05:26:22PM -0700, Chris Wright wrote:
> * Zack Brown (zbrown@tumblerings.org) wrote:
> > for instance, "Cset exclude: davej@suse.de|ChangeSet|20020403195622" is in
> > 2.5.8-pre2, as the full text of the changelog entry.
> 
> bk prs -r"davej@suse.de|ChangeSet|20020403195622" -hnd:REV: ChangeSet
> 
> That will give you the rev from that key in the Cset exclude message.

You can use cset keys just about anywhere you can use revision numbers
in the BK interface.  So,
% bk changes -r'davej@suse.de|ChangeSet|20020403195622'
does the right thing.

On Tue, Apr 20, 2004 at 05:38:20PM -0700, Zack Brown wrote:
> Will this give me the text of the changelog entry being reverted? That's
> what I need to find.

The "changes" command I give above will.

I'll see if I can get the "cset exclude" text to be an HREF.  In the
meantime, you can construct a working URL by appending the cset key to 
http://linux.bkbits.net:8080/linux-2.5/cset@

like so:
http://linux.bkbits.net:8080/linux-2.5/cset@davej@suse.de|ChangeSet|20020403195622

-andy
