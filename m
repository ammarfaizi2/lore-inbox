Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbTENAHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 20:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTENAHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 20:07:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27039
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263709AbTENAHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 20:07:20 -0400
Subject: Re: [patch] 2.4 fix to allow vmalloc at interrupt time
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mjacob@quaver.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052865254.1205.7.camel@dhcp22.swansea.linux.org.uk>
References: <20030512225654.GA27358@cm.nu>
	 <20030513140629.I83125@mailhost.quaver.net>
	 <1052865254.1205.7.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052868103.1206.28.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 May 2003 00:21:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-13 at 23:34, Alan Cox wrote:
> On Maw, 2003-05-13 at 22:11, Matthew Jacob wrote:
> > This fixes a buglet wrt doing vmalloc at interrupt time for 2.4.
> > 
> > get_vm_area should call kmalloc with GFP_ATOMIC- after all, it's
> > set up to allow for an allocation failure. As best as I read
> > the 2.4 code, the rest of the path through _kmem_cache_alloc
> > should be safe.
> 
> You aren't allow to vmalloc in an IRQ. The kmalloc is the least of
> your programs - you have to worry about the page table handling.

problems even. 1am isnt the best time for posting ;)

