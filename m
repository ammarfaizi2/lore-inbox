Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbTEAKz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 06:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbTEAKz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 06:55:26 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6040
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261207AbTEAKzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 06:55:25 -0400
Subject: Re: Loading a module multtiple times
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030501062800.3B9652C01B@lists.samba.org>
References: <20030501062800.3B9652C01B@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051783745.21168.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 11:09:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-01 at 07:22, Rusty Russell wrote:
> In message <33490.4.64.196.31.1051765837.squirrel@www.osdl.org> you write:
> > Argh, I looked thru insmod.c but not modprobe.c for a solution.
> 
> Well, you *could* do:
> 
> 	for i in `seq 1 9`; do
> 		sed "s/dummy/dumm$i/g" < dummy.ko > dumm$i.ko
> 		insmod dumm$i.ko
> 	done
> 
> But don't 8)

The dummy driver expects insmod -o dummy1 dummy; insmod -o dummy2 dummy
etc to be usable. You don't normally need lots of dummy drivers nowdays
since you can give one lots of addresses


