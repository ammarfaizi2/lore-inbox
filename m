Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVHSThu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVHSThu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 15:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVHSThu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 15:37:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46212 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S965051AbVHSTht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 15:37:49 -0400
Date: Fri, 19 Aug 2005 20:40:45 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Linus Torvalds <torvalds@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       vandrove@vc.cvut.cz, Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and mmap
Message-ID: <20050819194045.GG29811@parcelfarce.linux.theplanet.co.uk>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk> <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org> <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org> <20050819165332.GD29811@parcelfarce.linux.theplanet.co.uk> <20050819180218.GE29811@parcelfarce.linux.theplanet.co.uk> <4306301F.9060707@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4306301F.9060707@kolumbus.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 10:16:47PM +0300, Mika Penttilä wrote:
> Just out of curiosity - what protects even local filesystems against 
> concurrent truncate and symlink resolving when using the page cache helpers?

How do you get truncate(2) or ftruncate(2) to do something with a symlink?
The former follows links, the latter takes an open file...
