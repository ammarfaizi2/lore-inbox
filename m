Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVCWNLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVCWNLp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVCWNLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:11:44 -0500
Received: from mx01.cybersurf.com ([209.197.145.104]:51126 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S261724AbVCWNLl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:11:41 -0500
Subject: Re: memory leak in net/sched/ipt.c?
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Thomas Graf <tgraf@suug.ch>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Yichen Xie <yxie@cs.stanford.edu>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>,
       kaber@trash.net
In-Reply-To: <20050323125516.GP3086@postel.suug.ch>
References: <E1DE44X-0001QM-00@gondolin.me.apana.org.au>
	 <1111581618.1088.72.camel@jzny.localdomain>
	 <20050323125516.GP3086@postel.suug.ch>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1111583497.1089.92.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 23 Mar 2005 08:11:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 07:55, Thomas Graf wrote:
> * jamal <1111581618.1088.72.camel@jzny.localdomain> 2005-03-23 07:40

> > Just a small correction to patchlet:
> > The second kfree should check for existence of t.
> 
> t is either valid or NULL so it's not a problem, unless you want
> to create janitor work of course. ;->

if t is null you still goto rtattr_failure
I have seen people put little comments of "kfree will work if you
pass it NULL" - are you saying such assumptions exist all over
net/sched? didnt understand the janitor part.

cheers,
jamal

