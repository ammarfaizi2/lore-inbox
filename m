Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271747AbTGRMbj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271749AbTGRMbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:31:39 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:16655 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S271747AbTGRMbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:31:33 -0400
Date: Fri, 18 Jul 2003 14:46:46 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Duncan Sands <baldrick@wanadoo.fr>
cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       <schlicht@uni-mannheim.de>, <ricardo.b@zmail.pt>,
       <linux-kernel@vger.kernel.org>
Subject: Re: SET_MODULE_OWNER
In-Reply-To: <200307181212.09102.baldrick@wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0307181300450.11540-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003, Duncan Sands wrote:

> If you want to see what I have in mind, do
> 	rmmod uhci-hcd
> (or whatever your hcd is).  This shows that there was already a problem with
> unloading modules with zero refcount.

Ok, for the hcd you are right. And yes, I'd prefer to see the hcd's use 
count getting increased with any interface claimed by an usb client 
driver...

With lsmod reporting use count ==0 people might assume the module is 
unused and thus rmmod - not much fun if this is beneath a mounted fs.

Martin

PS: I've just tried this - it's even worse: not only would I expect fs 
damage, the box is OOPSing and BUGging like hell :-(
I'll take this to linux-usb-devel.

