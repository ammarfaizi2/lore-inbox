Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTE3KzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 06:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbTE3KzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 06:55:12 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60632
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263574AbTE3KzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 06:55:11 -0400
Subject: Re: [CHECKER] pcmcia user-pointer dereference
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Junfeng Yang <yjf@stanford.edu>, David Hinds <dhinds@sonic.net>
In-Reply-To: <17ACEE5A-921A-11D7-B8B8-000A95A0560C@us.ibm.com>
References: <17ACEE5A-921A-11D7-B8B8-000A95A0560C@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054289422.23566.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 May 2003 11:10:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-29 at 22:11, Hollis Blanchard wrote:
> I contacted David Hinds about this; the behavior is by design. User 
> space passes in a pointer to a kernel data structure, and the kernel 
> verifies it by checking a magic number in that structure.
> 
> It seems possible to perform some activity from user space to get the 
> magic number into (any) kernel memory, then iterate over kernel space 
> by passing pointers to the pcmcia ds_ioctl() until you manage to 
> corrupt something. But I'm not really a security guy...

That isnt safe - the pointer dereference could hit anything

