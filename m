Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbTIHQMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbTIHQLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:11:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:26552 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262736AbTIHQKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:10:15 -0400
Date: Mon, 8 Sep 2003 08:13:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Matthew Wilcox <willy@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
In-Reply-To: <20030908123846.GA15553@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0309080812200.11840-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Sep 2003, Andries Brouwer wrote:
> 
> > -#define BLKELVSET  _IOW(0x12,107,sizeof(blkelv_ioctl_arg_t))/* elevator set */
> > +#define BLKELVSET  _IOW(0x12,107,size_t)/* elevator set */
> 
> Here we lose information - I don't like that.
> Often it is important to know what kind of argument an ioctl has,
> and that info should be easy to find.

In the ones I converted I added a comment. That should be sufficient, and 
if anybody cares strongly, a patch to me to add comments to the ones 
Matthew converted will also be applied.

I'd _much_ rather have a comment than make up some new "bad define" thing.

		Linus

