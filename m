Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTJBRYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 13:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263423AbTJBRX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 13:23:57 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:13963 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263426AbTJBRXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 13:23:55 -0400
To: "Theodore Ts'o" <tytso@mit.edu>
cc: xen-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization 
In-Reply-To: Your message of "Thu, 02 Oct 2003 12:39:11 EDT."
             <20031002163911.GD13652@thunk.org> 
Date: Thu, 02 Oct 2003 18:23:47 +0100
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1A57B6-0007y9-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And the amount of work to port the architecture-specific porions of
> Xen to x86-xeno would be.....?   :-)

To allow efficient switching in and out of Xen we take a small amount
of every virtual address space, and also grab ring 0. Since we don't
hide that from overlying OSes, we couldn't do a full recursive
implementation of Xen -- we'd run out of rings (quickly) and address
space (eventually) :-) 

Full recursion needs full virtualization. Our approach offers much
better performance in the situations where full virtualization isn't
required -- i.e., where it's feasible to distribute a ported OS.

 -- Keir
