Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbUKIGHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbUKIGHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 01:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUKIGBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 01:01:07 -0500
Received: from postino3.roma1.infn.it ([141.108.26.5]:28593 "EHLO
	postino3.roma1.infn.it") by vger.kernel.org with ESMTP
	id S261398AbUKIFqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:46:44 -0500
Subject: Re: isa memory address
From: Antonino Sergi <Antonino.Sergi@roma1.infn.it>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <418FA2F1.2090003@osdl.org>
References: <1099901664.2718.92.camel@delphi.roma1.infn.it>
	 <418FA2F1.2090003@osdl.org>
Content-Type: text/plain
Message-Id: <1099979198.30102.21.camel@delphi.roma1.infn.it>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 09 Nov 2004 06:46:38 +0100
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.28.0.12; VDF 6.28.0.62
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 17:46, Randy.Dunlap wrote:
> Antonino Sergi wrote:
> > Hi,
> > 
> > I'm working with an old data acquisition system that uses an 8-bit card
> > in an ISA slot (address 0xd0000), by a simple driver I ported from
> > kernel 1.1.x to 2.2.24.
> > 
> > It works fine, but I'd like to have features by newer kernels (2.4 or
> > even 2.6), like new filesystems support.
> > 
> > On kernels >=2.4.0 check_region returns -EBUSY for that address,
> > but it is not actually used; I tried to understand if something has been
> > changed/removed, because of obsolescence of devices, in IO management,
> > but I couldn't.
> > 
> > Does anybody have any explanation/suggestion?
> 
> Please post contents of /proc/iomem .
> I'm guessing that it will show something like:
> 000e0000-000effff : Extension ROM
I can't. Now it is installed redhat 6.2 (2.2.14) (I gave up about this
issue some moths ago) and I think I won't ever succeed in satisfying rpm
dep to install a compiled 2.6.x. I'll try to compile it from scratch
ASAP 
> (but for address 000d0000).
> So then the question becomes how to assign/allocate it for your
> driver.
> 
> You might have to dummy up a call to release_resource() first,
> then use request_resource() to acquire it.
> Or just use the addresses anyway.... even though check_region() says
> -EBUSY. 
I'll try, but the question is why this would be needed?  

Thank you

> > PS:As I'm not subscribed, please CC me your answers.



Antonino Sergi <Antonino.Sergi@Roma1.INFN.it>

Radiodating Laboratory
Physics Department
University of Rome "La Sapienza"
P.le Aldo Moro 2
00185 Rome Italy
Tel +390649914206
Fax +390649914208


