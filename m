Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129600AbQJ1KI5>; Sat, 28 Oct 2000 06:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129817AbQJ1KIs>; Sat, 28 Oct 2000 06:08:48 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:8979 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129600AbQJ1KIi>;
	Sat, 28 Oct 2000 06:08:38 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: dwmw2@infradead.org (David Woodhouse), vojtech@suse.cz (Vojtech Pavlik),
        alan@redhat.com (Alan Cox), torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make agpsupport work with modversions 
In-Reply-To: Your message of "Sat, 28 Oct 2000 11:02:04 BST."
             <E13pSoP-0005Et-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Oct 2000 21:08:30 +1100
Message-ID: <7404.972727710@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2000 11:02:04 +0100 (BST), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> of get_module_symbol this weekend.  The inter-object registration code
>> will allow two objects to pass data to each other, it will not matter
>> whether the objects are both modules, one module and one built in (in
>> either order) or both built in.  When modules are involved there will
>> be full module locking.
>
>Dont forget that one of the objects may not even be present, or may be
>loaded later.

How could I forget it?  You have defined the heart of the problem,
either object might be built into the kernel, might be a module or
might not even be there, in any case the load order is undefined.  That
is why existing code is kludging things by using get_module_symbol().
inter_module_register, unregister, get, put will solve the inter object
problem but using a clean interface that works with symbol versions.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
