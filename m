Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVA1Vnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVA1Vnu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 16:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVA1Vnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 16:43:49 -0500
Received: from mail1.kontent.de ([81.88.34.36]:45528 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262771AbVA1Vmx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 16:42:53 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Josh Boyer <jdub@us.ibm.com>
Subject: Re: Why does the kernel need a gig of VM?
Date: Fri, 28 Jan 2005 22:42:58 +0100
User-Agent: KMail/1.7.1
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
References: <41FA9B37.1020100@comcast.net> <1106944969.7542.13.camel@windu.rchland.ibm.com>
In-Reply-To: <1106944969.7542.13.camel@windu.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501282242.58606.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 28. Januar 2005 21:42 schrieb Josh Boyer:
> Because of various reasons.  Normal kernel space virtual addresses
> usually start at 0xc0000000, which is where the 3GiB userspace
> restriction comes from.  
> 
> Then there is the vmalloc virtual address space, which usually starts at
> a higher address than a normal kernel address.  Along the same lines are
> ioremap addresses, etc.
> 
> Poke around in the header files.  I bet you'll find lots of reasons.

Probably, this some FAQ, but anyway. The kernel needs physical memory
present and accessible all the time from all contexts. This is mapped into
this area. All other RAM is called High Mem and needs to be specifically
mapped before it can be used from kernel space.

	Regards
		Oliver
