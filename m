Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbTGFQdK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266694AbTGFQdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:33:10 -0400
Received: from franka.aracnet.com ([216.99.193.44]:40075 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S266691AbTGFQdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:33:04 -0400
Date: Sun, 06 Jul 2003 09:47:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: gigag@bezeqint.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patch for 3.5/0.5 address space split
Message-ID: <26930000.1057510039@[10.10.2.4]>
In-Reply-To: <bac2312a.9f399e92.8177000@mas3.bezeqint.net>
References: <bac2312a.9f399e92.8177000@mas3.bezeqint.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could anybody point out to patches available for 3.5/0.5 address 
> space split for 2.4 and 2.5 kernels?

It's in 2.4-aa and 2.5-mjb trees. 2.5 has the added feature that it
can now do that for PAE (> 4GB) machines (from Dave Hansen). 

> Any other working options? I managed to compile 2.4.21 kernel 
> with 1/3 split, but not with 0.5/3.5. The last one simply doesn't 
> boot. What could I be doing wrong?

You can chage PAGE_OFFSET yourself, but there's a few places to change
it ... do a grep -r for "C0000000", and hack all those - one of them
is in some .lds file or something, I forget.

M.

