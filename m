Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTFBOfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTFBOfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:35:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28646
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262368AbTFBOfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 10:35:30 -0400
Subject: Re: [PATCH][ATM] assorted he driver cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, acme@conectiva.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306020236.h522a8sG024853@ginger.cmf.nrl.navy.mil>
References: <200306020236.h522a8sG024853@ginger.cmf.nrl.navy.mil>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054561831.7494.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 14:50:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-02 at 03:34, chas williams wrote:
> smp machines either.  i dont believe the i386 will reorder
> read/writes from multiple cpus so in theory it would be safe to
> do away with this lock on smp i386's.  the only arch that 
> can reorder (and actually has posted read/writes) is the ia64/sn2.

The only i386 platforms that will re-order writes I know of are the
Natsemi Geode (which will do magic so that the write order seen
by PCI is always ordered), Pentium Pro (fence bug) and IDT
Winchip (but only to main memory)


