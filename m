Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTFHCHI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 22:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTFHCHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 22:07:08 -0400
Received: from dp.samba.org ([66.70.73.150]:10136 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264197AbTFHCHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 22:07:07 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16098.40134.797553.706780@argo.ozlabs.ibm.com>
Date: Sun, 8 Jun 2003 12:17:42 +1000
To: Daniel Jacobowitz <dan@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: __user annotations
In-Reply-To: <20030607164936.GA18862@nevyn.them.org>
References: <16097.12932.161268.783738@argo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0306061738200.31112-100000@home.transmeta.com>
	<20030607164936.GA18862@nevyn.them.org>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz writes:

> I don't know why they were getting rejected for Paul, though.  Did you
> have GNU set to -ansi mode?

I was using gcc-3.3.  I tried both -std=c99 and -std=gnu99, and gcc-3.3
didn't like the code either way, nor did it like it with no -std
option.  Gcc-3.2 compiles it perfectly happily though, so that is what
I am doing for now.

(I did have to hack some of the pre-definitions in check.c to make it
useful on PPC, e.g., I changed it to pre-define __ppc__ instead of
__i386__.)

Paul.
