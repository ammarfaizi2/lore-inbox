Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWHKKQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWHKKQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 06:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbWHKKQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 06:16:49 -0400
Received: from ns1.suse.de ([195.135.220.2]:54672 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932075AbWHKKQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 06:16:48 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH for review] [127/145] i386: move kernel_thread_helper into entry.S
Date: Fri, 11 Aug 2006 12:16:07 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060810 935.775038000@suse.de> <200608111038.17716.ak@suse.de> <44DC6EAA.76E4.0078.0@novell.com>
In-Reply-To: <44DC6EAA.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608111216.07602.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ENTRY(kernel_thread_helper)
> 	CFI_STARTPROC
> 	movl %edx,%eax
> 	pushl %edx
> 	CFI_ADJUST_CFA_OFFSET 4
> 	call *%ebx
> 	pushl %eax
> 	CFI_ADJUST_CFA_OFFSET 4
> 	call do_exit
> 	CFI_ENDPROC
> ENDPROC(kernel_thread_helper)
> 
> (i.e. tracking the stack pointer movement, but not the register values
> other than the return address)

Done thanks.

-Andi
