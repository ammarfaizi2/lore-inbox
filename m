Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270122AbTGMF3H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 01:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270128AbTGMF3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 01:29:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21184 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270122AbTGMF3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 01:29:05 -0400
Date: Sat, 12 Jul 2003 22:34:49 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@intercode.com.au>
Cc: jkenisto@us.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       akpm@osdl.org, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk,
       rddunlap@osdl.org, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH - RFC] [1/2] 2.6 must-fix list - kernel error reporting
Message-Id: <20030712223449.550d822a.davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0307131052420.2146-100000@excalibur.intercode.com.au>
References: <20030711224142.557b5b5e.davem@redhat.com>
	<Mutt.LNX.4.44.0307131052420.2146-100000@excalibur.intercode.com.au>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003 11:17:35 +1000 (EST)
James Morris <jmorris@intercode.com.au> wrote:

> On Fri, 11 Jul 2003, David S. Miller wrote:
> 
> > Oops, turns out this doesn't work.  data_ready is never NULL, look at
> > how netlink_kernel_create() works.
> 
> It's ok: sk->data_ready is never null, but nlk_sk(sk)->data_ready will be 
> null unless an input function is provided there.
> 
> > Also, the broadcast case probably needs to be handled
> > too?
> 
> Netlink sockets created by netlink_kernel_create() do not subscribe to any 
> groups and are not broadcast to.

Oops, you're right on both counts, I brainfarted here.

I'll apply your original patch, thanks.
