Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317939AbSGZSPp>; Fri, 26 Jul 2002 14:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317948AbSGZSPp>; Fri, 26 Jul 2002 14:15:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51705 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317939AbSGZSPo>; Fri, 26 Jul 2002 14:15:44 -0400
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell Lewis <spamhole-2001-07-16@deming-os.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D418DFD.8000007@deming-os.org>
References: <3D418DFD.8000007@deming-os.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jul 2002 20:33:25 +0100
Message-Id: <1027712005.14773.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 18:59, Russell Lewis wrote:
> I have spent some time working on AIX, which pages its kernel memory. 
>  It pins the interrupt handler functions, and any data that they access, 
> but does not pin the other code.
> 
> I'm looking for links as to why (unless I'm mistaken) Linux doesn't do 
> this, so I can better understand the system.

Memory is relatively cheap, and the complexity of such a paging kernel
is huge (you have to pin down disk driver and I/O paths for example).
Linux prefers to try to keep simple debuggable approaches to things. 

