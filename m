Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTFPLHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 07:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTFPLHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 07:07:38 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:7431 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263722AbTFPLHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 07:07:37 -0400
Date: Mon, 16 Jun 2003 13:21:28 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: =?unknown-8bit?Q?J=F6rn_Engel_=3Cjoern=40wohnheim=2Efh-wedel=2Ede=3E?=@win.tue.nl
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030616112128.GA9415@win.tue.nl>
References: <20030615160524.GD1063@wohnheim.fh-wedel.de> <20030615182642.A19479@infradead.org> <20030615173926.GH1063@wohnheim.fh-wedel.de> <20030615184417.A19712@infradead.org> <20030615175815.GI1063@wohnheim.fh-wedel.de> <20030615190349.A21931@infradead.org> <20030615181424.GJ1063@wohnheim.fh-wedel.de> <20030615191853.A22150@infradead.org> <20030615234909.A11481@pclin040.win.tue.nl> <20030616091215.GA17446@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030616091215.GA17446@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 11:12:15AM +0200, J?rn Engel wrote:
> On Sun, 15 June 2003 23:49:09 +0200, Andries Brouwer wrote:
> > On Sun, Jun 15, 2003 at 07:18:53PM +0100, Christoph Hellwig wrote:
> > > 
> > > The only places where this should happen is mounting the rootfs.
> > > mount(8) has it's own filesystem type detection code and doesn't
> > > call mount(2) unless it found a matching filesystem type.
> > 
> > Too optimistic a description.
> > Any person who likes reliable results will give mount a -t option.
> > If someone likes to gamble, and doesnt mind system crashes, he'll
> > omit the -t and let mount guess what the type should have been.
> > Mount has a battery of heuristics for a handful of filesystems.
> > If any of these succeeds mount will try that type.
> > If none succeeds, mount will try consecutively all types listed
> > in /proc/filesystems for which no heuristic is present.
> 
> Actually, I have one example of reality matching Christoph's
> description, so he wins this fight as well.

Please don't distribute misinformation.
If you doubt, read the mount(8) code first.


