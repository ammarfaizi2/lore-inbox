Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbUCYDhT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 22:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbUCYDhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 22:37:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:54954 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263140AbUCYDhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 22:37:15 -0500
Date: Wed, 24 Mar 2004 19:37:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Williams <peterw@aurema.com>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RPM failures when using 2.6.X kernels on RH9
In-Reply-To: <406239AB.6060202@aurema.com>
Message-ID: <Pine.LNX.4.58.0403241933540.1106@ppc970.osdl.org>
References: <406239AB.6060202@aurema.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Mar 2004, Peter Williams wrote:
>
> When attempting to install RPM packages on RH9 using any 2.6.X kernel I 
> get the following error messages:

Yes. Buggy rpm binary which tries to use direct-IO without proper 
alignment etc. 

Work around by doing

	export LD_ASSUME_KERNEL=2.4.1

and then upgrade to a fixed rpm binary as quickly as possible.

		Linus
