Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTIHSla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTIHSla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:41:30 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:46341 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263467AbTIHSl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:41:29 -0400
Date: Mon, 8 Sep 2003 20:40:23 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Matthew Wilcox <willy@debian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
Message-ID: <20030908204023.A1060@pclin040.win.tue.nl>
References: <20030908123846.GA15553@win.tue.nl> <Pine.LNX.4.44.0309080812200.11840-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309080812200.11840-100000@home.osdl.org>; from torvalds@osdl.org on Mon, Sep 08, 2003 at 08:13:53AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 08:13:53AM -0700, Linus Torvalds wrote:

> I'd _much_ rather have a comment than make up some new "bad define" thing.

Pity.

(It is not important, but having the type formally visible
makes it easier to do automatic verification of contexts like
	FOOIOCTL:
	    {
		struct foo_arg *uarg = (struct foo_arg *) arg;
		err = handle_fooioctl(fd, uarg);
		break;
	    }
One might even wish to generate them automatically.
I think relegating the type to a comment is a microstep in the wrong direction.)

Andries



[That reminds me - you announced sparse, a source checker.
Is it available for non bk users? I haven't seen a URL.]

