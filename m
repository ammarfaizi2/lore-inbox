Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTDSVgw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 17:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263476AbTDSVgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 17:36:52 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:47115 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263475AbTDSVgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 17:36:51 -0400
Date: Sat, 19 Apr 2003 23:48:45 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Christian Staudenmayer <eggdropfan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-ac2 and lilo
Message-ID: <20030419214845.GA19821@win.tue.nl>
References: <20030419205152.GA19800@win.tue.nl> <20030419211356.25316.qmail@web41804.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030419211356.25316.qmail@web41804.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 19, 2003 at 02:13:56PM -0700, Christian Staudenmayer wrote:

> Hey Andries,
> 
> before taking your message into account, i think you misunderstood my
> question:
> 
> > Hmm. You did not forget to rerun LILO or so?
> 
> the error occurs when _running_ lilo, i.e. after typing "lilo" at the prompt.

Yes, I misunderstood. Interesting that the running of an ordinary utility
depends on the kernel in this way.

I cry when I read the source.

    if ((size = read(l_fd,buff,sizeof(buff)+1)) < 0)
        die("read %s: %s",loader,strerror(errno));
    if (size > sizeof(buff))
        die("Chain loader %s is too big",loader);

Precisely what LILO does can be followed better by giving one or more -v
options.

The question remains: if you replace (in the kernel) the -ac2 msdos.c
by the vanilla msdos.c, does that improve things?

By the way, LILO has been a beautiful boot loader, but I think
it is slowly dying.

Andries

