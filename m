Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTGFQtq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTGFQtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:49:46 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:12560 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S262601AbTGFQtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:49:45 -0400
Date: Mon, 7 Jul 2003 03:03:58 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Matthew Wilcox <willy@debian.org>, Patrick Mochel <mochel@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: kobjects, sysfs and the driver model make my head hurt
In-Reply-To: <Pine.LNX.4.55.0307060935140.14675@bigblue.dev.mcafeelabs.com>
Message-ID: <Mutt.LNX.4.44.0307070300180.930-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003, Davide Libenzi wrote:

> On Sun, 6 Jul 2003, Matthew Wilcox wrote:
> 
> > Why on earth does it return the value of its argument?
> 
> Maybe for the same reason 'strcpy' returns 'dest'. It allows you to use
> the function in a function parameter :

It also makes calling code cleaner when copying refcounted objects:

e.g.
	new->foo = foo_get(old->foo);
	new->bar = bar_get(old->bar);

otherwise, you'd have to do:

	foo_get(old->foo);
	new->foo = old->foo;
	bar_get(old->bar);
	new->bar = old->bar;


- James
-- 
James Morris
<jmorris@intercode.com.au>

