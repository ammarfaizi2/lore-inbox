Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945982AbWGOCWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945982AbWGOCWf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 22:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945981AbWGOCWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 22:22:35 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:52455 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1945978AbWGOCWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 22:22:34 -0400
Date: Fri, 14 Jul 2006 20:22:33 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@elte.hu, linux-arch@vger.kernel.org,
       David Howells <dhowells@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/02] remove set_wmb - doc update
Message-ID: <20060715022233.GA1578@parisc-linux.org>
References: <1152882288.1883.30.camel@localhost.localdomain> <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org> <Pine.LNX.4.64.0607141017520.5623@g5.osdl.org> <1152898699.27135.20.camel@localhost.localdomain> <Pine.LNX.4.64.0607141040550.5623@g5.osdl.org> <20060714105841.4490c0e2.akpm@osdl.org> <1152907501.27135.44.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152907501.27135.44.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 04:05:01PM -0400, Steven Rostedt wrote:
>  There are some more advanced barrier functions:
>  
>   (*) set_mb(var, value)
> - (*) set_wmb(var, value)
>  
> -     These assign the value to the variable and then insert at least a write
> -     barrier after it, depending on the function.  They aren't guaranteed to
> +     This assigns the value to the variable and then inserts at least a write
> +     barrier after it, depending on the function.  It isn't guaranteed to
>       insert anything more than a compiler barrier in a UP compilation.

"There is one more advanced barrier function"?  ;-)  Or did you want to
remove set_mb()?

Plus, the "depending on the function" bit means "respectively".  So what
you really want as help is something like:

	This assigns the value to the variable and then inserts a
	barrier after the assignment.  It isn't guaranteed to insert
	anything more than a compiler barrier in a UP compilation.
