Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTKTTMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 14:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTKTTMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 14:12:16 -0500
Received: from mail.enyo.de ([212.9.189.167]:37137 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262848AbTKTTMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 14:12:15 -0500
Date: Thu, 20 Nov 2003 20:12:09 +0100
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Valdis.Kletnieks@vt.edu, Daniel Gryniewicz <dang@fprintf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031120191209.GA9859@deneb.enyo.de>
References: <1068512710.722.161.camel@cube> <03111209360001.11900@tabby> <20031120172143.GA7390@deneb.enyo.de> <03112013081700.27566@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03112013081700.27566@tabby>
User-Agent: Mutt/1.5.4i
From: Florian Weimer <fw@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:

> > > > > 	int sys_copy(int fd_src, int fd_dst)

> > The default attributes in the new location might be less strict than the
> > attributes of the source file.
> 
> So what. the user was authorized to open the input file. The user was
> authorized to open the output file. A file copy should be possible remotely
> since the equivalent implementation of a local read/write loop would
> accomplish the same thing.

The potential for race conditions worries me.  However, the questions
you gave are more fundamental and may be enough to kill this idea (if it
wasn't already dead)...
