Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129801AbQLAXkq>; Fri, 1 Dec 2000 18:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129857AbQLAXkg>; Fri, 1 Dec 2000 18:40:36 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:40206 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129801AbQLAXkT>;
	Fri, 1 Dec 2000 18:40:19 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Al Peat <al_kernel@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: put/get_module_symbol vs. inter_module_register/put/get/etc. 
In-Reply-To: Your message of "Fri, 01 Dec 2000 10:52:35 -0800."
             <20001201185235.44106.qmail@web10105.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 02 Dec 2000 10:09:47 +1100
Message-ID: <21319.975712187@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2000 10:52:35 -0800 (PST), 
Al Peat <al_kernel@yahoo.com> wrote:
>  I've followed the thread on "Persistent module
>storage" but haven't come across a general explanation
>of the changes to the inter-module symbol stuff
>between 2.4test10 and test11.  Anyone care to comment
>on the differences or on whether this is going to be a
>stable API for 2.4 (it won't be changed again)?

You are confusing two completely different topics.  inter_module_xxx
replaced get_module_symbol because the latter was a bad interface, it
violated module layering and broke when symbol versions were turned on.
inter_module_xxx is clean and stable, it has also been sent to Alan Cox
for inclusion in 2.2 kernels, although 2.2 will still have
get_module_symbol for backwards compatibility.

Persistent module data is the ability to save module parameters at
unload time.  It only makes sense for parameters that are changed by
users after load, e.g. volume controls, TV tuner settings etc.  That
facility is almost completely in user space and requires very few
changes to modules.  Watch this space.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
