Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQJ1Jzm>; Sat, 28 Oct 2000 05:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129442AbQJ1Jzb>; Sat, 28 Oct 2000 05:55:31 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:4371 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129108AbQJ1JzZ>;
	Sat, 28 Oct 2000 05:55:25 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@redhat.com>
cc: dwmw2@infradead.org (David Woodhouse), vojtech@suse.cz (Vojtech Pavlik),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make agpsupport work with modversions 
In-Reply-To: Your message of "Sat, 28 Oct 2000 05:40:28 EDT."
             <200010280940.e9S9eSx02362@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Oct 2000 20:55:18 +1100
Message-ID: <7155.972726918@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2000 05:40:28 -0400 (EDT), 
Alan Cox <alan@redhat.com> wrote:
>> cc list trimmed.  Nobody has come up with a "must have" reason for
>> get_module_symbol and that interface is broken as designed.  I will be
>
>Nobody has come up with a 'must break existing sane code' reason either.

Existing code is not sane, it does not work with symbol versions.  The
only code left in the kernel that uses get_module_symbol is agp, drm
and mtd, all of which I will be fixing at the same time.

>> will allow two objects to pass data to each other, it will not matter
>> whether the objects are both modules, one module and one built in (in
>> either order) or both built in.  When modules are involved there will
>> be full module locking.
>
>You have no consensus on this. None at all. It is also past the 2.4test
>point for making this change.

Linus wants get_module_symbol removed.
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg08791.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
