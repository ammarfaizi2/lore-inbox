Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAIKq2>; Tue, 9 Jan 2001 05:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRAIKqT>; Tue, 9 Jan 2001 05:46:19 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:3308 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129183AbRAIKqG>; Tue, 9 Jan 2001 05:46:06 -0500
Message-ID: <3A5AED76.B2F60F8D@uow.edu.au>
Date: Tue, 09 Jan 2001 21:52:38 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: John Fremlin <vii@penguinpowered.com>
CC: linux-kernel@vger.kernel.org,
        linux-power@phobos.fachschaften.tu-muenchen.de,
        Andy Henroid <andy_henroid@yahoo.com>, apm@linuxcare.com.au,
        linux-laptop@vger.kernel.org
Subject: Re: Unified power management userspace policy
In-Reply-To: <m2lmsld4rk.fsf@boreas.yi.org.>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Fremlin wrote:
> 
> Hi all!
> 
> At the moment there are two power management drivers in the linux
> kernel (AFAIK). They each have different userspace interfaces --
> /proc/apm and /dev/apmctl and /proc/sys/acpi/events or something. This
> is not altogether bad, but as they do the same thing, it might be nice
> to unify (part) of the interface. In fact this is already done for the
> in kernel interface with pm_send_all.
>

John,

Could you please use call_usermodehelper() in this patch
rather than exec_usermodehelper()?  I want to kill
exec_usermodehelper() sometime.

Plus your code will be simpler - no need to create
your own kernel thread.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
