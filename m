Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbTFVLck (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 07:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbTFVLck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 07:32:40 -0400
Received: from mail.consultit.no ([213.239.74.125]:24496 "EHLO
	kosat.consultit.no") by vger.kernel.org with ESMTP id S264921AbTFVLcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 07:32:39 -0400
Date: Sun, 22 Jun 2003 13:46:42 +0200
From: Eivind Tagseth <eivindt@multinet.no>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA Compact Flash adapter in 2.5.72
Message-ID: <20030622114642.GB1785@tagseth-trd.consultit.no>
References: <20030620081846.GB2451@tagseth-trd.consultit.no> <20030620211640.B913@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620211640.B913@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King <rmk@arm.linux.org.uk> [030620 22:18]:
> Hmm, you mention pcmcia-cs 3.2.4 later in your mail.  Are you trying to
> get pcmcia-cs modules to work with the 2.5.72 pcmcia subsystem?

Of course not.  But I need pcmcia-cs for cardmgr and other tools.  The
modules are from 2.5.72.  I've also got a wireless card, which works
fine.

After learning about the -F flag to strace, I've been able to figure
out a little bit more about what cardmgr is doing:

3158  ioctl(4, 0xc050643c, 0x8054160)   = -1 EINVAL (Invalid argument)

As far as I can see, this is cardmgr calling ioctl(xx, DS_BIND_REQUEST, xx),
which is defined as:
	_IOWR('d', 60, bind_info_t)

> There is this which fixes some people problems, and is already in Linus'
> recent bk tree.  Does this solve your problem?

Nope, no change I'm afraid.




Eivind
