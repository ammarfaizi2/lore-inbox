Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUASX6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUASX6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:58:21 -0500
Received: from galileo.bork.org ([66.11.174.156]:187 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S263898AbUASX5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:57:16 -0500
Date: Mon, 19 Jan 2004 18:57:13 -0500
From: Martin Hicks <mort@bork.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: john moser <bluefoxicy@linux.net>, linux-kernel@vger.kernel.org
Subject: Re: struct task_struct -> task_t
Message-ID: <20040119235713.GP27591@localhost>
References: <20040119221757.411BB3958@sitemail.everyone.net> <20040119222434.GO21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119222434.GO21151@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jan 19, 2004 at 10:24:34PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Jan 19, 2004 at 02:17:57PM -0800, john moser wrote:
> > It has come to my attention that in some places in the kernel, 'struct task_struct'
> > is used; and in others, 'task_t' is used.  Also, 'task_t' is
> > 'typedef struct task_struct task_t;'.
> > 
> > I made a small script to change around as much as I could so that everything uses
> > task_t,
> 
> What the fsck for?  If anything, the opposite (and removal of that typedef)
> would be preferable.

John,

As Al is trying to point out, we try to discourage the use of typedefs
in the kernel.  It is much easier to see that blah_t is really a struct
if we always use 'struct blah'.

mh

-- 
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE
