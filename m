Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbTIXAik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTIXAij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:38:39 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22675
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261203AbTIXAii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:38:38 -0400
Date: Wed, 24 Sep 2003 02:38:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: zanussi@comcast.net, Ruth.Ivimey-Cook@ivimey.org, j.grootheest@euronext.nl,
       willy@w.ods.org, marcelo.tosatti@cyclades.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030924003847.GJ16314@velociraptor.random>
References: <Pine.LNX.4.44.0309231748310.27885-100000@gatemaster.ivimey.org> <3F708576.4080203@comcast.net> <20030923175320.GD1269@velociraptor.random> <20030923143754.6b9efbc9.akpm@osdl.org> <20030923222229.GQ1269@velociraptor.random> <20030923171505.2a8d23bb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923171505.2a8d23bb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 05:15:05PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > +__setup("log_buf_len=", log_buf_len_setup);
> 
> Specifying this in units of bytes is a pain.
> 
> How about we make it "log_buf_kbytes", and multiply it by 1024?

note: that's a memparse, that's not unit of bytes, you can wite 256k or
1M or 2m just now and it'll just work

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
