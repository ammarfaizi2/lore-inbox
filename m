Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVCEWVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVCEWVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVCEWVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:21:09 -0500
Received: from mx1.mail.ru ([194.67.23.121]:21366 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261292AbVCEWU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:20:59 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: 2.6.11-mm1 (x86-abstract-discontigmem-setup.patch)
Date: Sun, 6 Mar 2005 01:21:19 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org
References: <200503051535.24372.adobriyan@mail.ru> <1110049138.6446.3.camel@localhost>
In-Reply-To: <1110049138.6446.3.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200503060121.19354.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 March 2005 20:58, Dave Hansen wrote:
> On Sat, 2005-03-05 at 15:35 +0200, Alexey Dobriyan wrote:
> > > +	}
> > > +	printk(KERN_DEBUG "\n");
> > 	       ^^^^^^^^^^
> > > +}
> > 
> > Too much KERN_DEBUG.
> 
> On my system, that ends up printing out 4 or 5 lines of output per node,
> but it's quite invaluable if you're debugging early memory setup issues.
> It is KERN_DEBUG after all.  What does it do on your system?
> 
> I'm not horribly opposed to removing some of this output, let's just
> make sure...

You misundestood. I'm not proposing to remove these printk's altogether. I'm
for removing KERN_DEBUG solely in the middle of the line.

Try the following program with and without 3-rd and 4-th KERN_DEBUG.

	Alexey
============================================================================
#include <stdio.h>

#define KERN_DEBUG "<7>"

int main(void)
{
        int i;

        printf(KERN_DEBUG "  Setting physnode_map array to node:\n");
        printf(KERN_DEBUG "  ");
        for (i = 0; i < 10; i++)
                printf(KERN_DEBUG "%d ", i);
        printf(KERN_DEBUG "\n");

        return 0;
}
