Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbTDSNNd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 09:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTDSNNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 09:13:33 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2511
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263384AbTDSNNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 09:13:32 -0400
Subject: Re: [TRIVIAL] kstrdup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EA0D524.7010309@pobox.com>
References: <20030419041526.5E3982C093@lists.samba.org>
	 <3EA0D524.7010309@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050755240.3277.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Apr 2003 13:27:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-19 at 05:48, Jeff Garzik wrote:
> > Completely disagree.  Write the most straightforward code possible,
> > and then if there proves to be a problem, optimize.  Optimizations
> > where there's no actual performance problem should be left to the
> > compiler.
> 
> Since the kernel does its own string ops, the compiler does not have 
> enough information to deduce that further optimization is possible.
> 
> 
> > Case in point: gcc-3.2 on -O2 on Intel is one instruction longer for
> > your version.
> 
> And?  It's still slower.

You are arguing over a 1 instruction, probably sub 1 clock scheduling
matter on a call which is not used on any fast or common path. If you
shaved 1 clock off the timer handling instead you'd make a lot more
difference..

