Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUGZVFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUGZVFC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUGZVBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:01:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:7133 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266016AbUGZUoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:44:30 -0400
Date: Mon, 26 Jul 2004 13:42:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
Message-Id: <20040726134258.37531648.akpm@osdl.org>
In-Reply-To: <20040726202946.GD26075@ca-server1.us.oracle.com>
References: <cone.1090801520.852584.20693.502@pc.kolivas.org>
	<20040725173652.274dcac6.akpm@osdl.org>
	<cone.1090802581.972906.20693.502@pc.kolivas.org>
	<20040726202946.GD26075@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> On Mon, Jul 26, 2004 at 10:43:01AM +1000, Con Kolivas wrote:
> > Low memory boxes and ones that are heavily laden with applications find 
> > that ends up making things slow down trying to keep all applications in 
> > physical ram.
> 
> 	Lowish memory boxes with plain desktop loads find that the default
> of '60' is a terrible one (I'm speaking of 1GHz-ish machines with 256MB
> (like mine) or 512MB (like a guy next to me)).  Every person I know who
> installs 2.6 complains about how it feels slow and choppy.  I tell them
> "The first thing I do after installing 2.6 is set swappiness to '20'."
> Sure enough, they set swappiness to 20 and their box starts behaving
> like a properly tuned one.
> 	I don't know what workload the default of '60' is for, but for
> the (128MB < x < 1GB) of RAM case, it sucks (and I've seen the same
> behavior on a 300MHz 196MB box).
> 

Yes, I think 60% is about right for a 512-768M box.  Too high for the
smaller machines, too low for the larger ones.

More intelligent selection of the initial value is needed.
