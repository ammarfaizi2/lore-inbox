Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbUKRKNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbUKRKNX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbUKRKLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:11:49 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:31447 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262693AbUKRKJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:09:41 -0500
To: Gerd Knorr <kraxel@bytesex.org>
cc: Andrew Morton <akpm@osdl.org>, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       linux-kernel@vger.kernel.org, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, alan@redhat.com, Ian.Pratt@cl.cam.ac.uk
Subject: Re: [patch 3] Xen core patch : runtime VT console disable 
In-reply-to: Your message of "18 Nov 2004 10:59:05 +0100."
             <87oehvxyty.fsf@bytesex.org> 
Date: Thu, 18 Nov 2004 10:09:31 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CUjEK-00055s-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Morton <akpm@osdl.org> writes:
> 
> > >  +int console_use_vt = 1;
> > 
> > Should this not have static scope?
> 
> I'd like to have that one globally visible, so that code somewhere in
> arch/{xen|um} can enable/disable that at boot time depending on the
> virtual machine configuration.

Yep, that's why we need it global. In
arch/xen/i386/kernel/setup.c we set it to zero if the virtual
machine doesn't have access to the console hardware.

Ian
