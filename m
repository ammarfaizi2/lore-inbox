Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbUKREky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUKREky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 23:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbUKREky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 23:40:54 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:25348
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262541AbUKREku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 23:40:50 -0500
Message-Id: <200411180654.iAI6sTQ3008495@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Andrew Morton <akpm@osdl.org>
cc: Ian.Pratt@cl.cam.ac.uk, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       Keir.Fraser@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value 
In-Reply-To: Your message of "Wed, 17 Nov 2004 19:09:33 PST."
             <20041117190933.16e8b8ed.akpm@osdl.org> 
References: <E1CUaxA-0006Fa-00@mta1.cl.cam.ac.uk> <200411180508.iAI58iQ3007886@ccure.user-mode-linux.org>  <20041117190933.16e8b8ed.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Nov 2004 01:54:29 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org said:
> But heck - why bother?  The current patch adds just one line of code
> in one place, and the compiler will toss it away anyway for all but
> xen and um. 

Agree, but on a conceptual level, this is allowing the arch to swipe pages 
arbitrarily out from under the nose of the generic page allocator.  Plus, the 
code that's being bypassed has to be implemented in some form in the arch.  
That's not my concern, or yours, necessarily, but it does suggest that the 
interface is being abused.

				Jeff

