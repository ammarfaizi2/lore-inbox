Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTEFOt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTEFOtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:49:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8320 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263791AbTEFOtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:49:49 -0400
Date: Tue, 6 May 2003 16:02:19 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Alex Riesen <alexander.riesen@synopsys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: allow rename to "--bind"-mounted filesystem
Message-ID: <20030506150219.GM10374@parcelfarce.linux.theplanet.co.uk>
References: <20030506100435.GH890@riesen-pc.gr05.synopsys.com> <20030506143026.GL10374@parcelfarce.linux.theplanet.co.uk> <20030506143459.GA25606@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506143459.GA25606@riesen-pc.gr05.synopsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 04:34:59PM +0200, Alex Riesen wrote:
> viro@parcelfarce.linux.theplanet.co.uk, Tue, May 06, 2003 16:30:26 +0200:
> > On Tue, May 06, 2003 at 12:04:35PM +0200, Alex Riesen wrote:
> > > Hi,
> > > i just came over this patch, and wondered why is it missing
> > > in both 2.4 and 2.5 (the code in do_rename is identical in both
> > > kernels).
> > > 
> > > Are such renames really not allowed, or was it just fixed differently?
> > 
> > Such remames are _deliberately_ not allowed.
> > 
> 
> because that would be against semantics of a mounted filesystem?
> (which, in turn, would break something)

Binding a subtree creates a sandbox of sorts.  You can bind a bunch of
subtrees of the same fs into namespace and have normal protection
against rename and link between them.
