Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUC1NIY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 08:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUC1NIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 08:08:24 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:1546 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261744AbUC1NIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 08:08:22 -0500
Date: Sun, 28 Mar 2004 15:08:11 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, chas@cmf.nrl.navy.mil
Subject: Re: [PATCH-2.4.26] ATM cleanup
Message-ID: <20040328130811.GA7345@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet> <20040328125852.GH24421@pcw.home.local> <20040328130317.GA8775@dingdong.cryptoapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328130317.GA8775@dingdong.cryptoapps.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 05:03:17AM -0800, Chris Wedgwood wrote:
> On Sun, Mar 28, 2004 at 02:58:52PM +0200, Willy TARREAU wrote:
> 
> > +++ ./net/atm/mpoa_proc.c	Sun Mar 28 14:52:34 2004
> > @@ -102,7 +102,7 @@
> >  			     size_t count, loff_t *pos){
> >          unsigned long page = 0;
> >  	unsigned char *temp;
> > -        ssize_t length  = 0;
> > +        int length  = 0;
> >  	int i = 0;
> >  	struct mpoa_client *mpc = mpcs;
> >  	in_cache_entry *in_entry;
> 
> no tabs?

Good catch, it seems there are many lines without tabs in this file,
but I don't want to re-indent all the file. At least, the following
patch fixes makes it better for the concerned function.

Cheers,
Willy


--- ./net/atm/mpoa_proc.c.orig	Sun Mar 28 15:04:17 2004
+++ ./net/atm/mpoa_proc.c	Sun Mar 28 15:06:25 2004
@@ -100,9 +100,9 @@
  */
 static ssize_t proc_mpc_read(struct file *file, char *buff,
 			     size_t count, loff_t *pos){
-        unsigned long page = 0;
+	unsigned long page = 0;
 	unsigned char *temp;
-        ssize_t length  = 0;
+	int length  = 0;
 	int i = 0;
 	struct mpoa_client *mpc = mpcs;
 	in_cache_entry *in_entry;

