Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279454AbRJ3J0h>; Tue, 30 Oct 2001 04:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279902AbRJ3J02>; Tue, 30 Oct 2001 04:26:28 -0500
Received: from wiproecmx1.wipro.com ([164.164.31.5]:54696 "EHLO
	wiproecmx1.wipro.com") by vger.kernel.org with ESMTP
	id <S279496AbRJ3J0X>; Tue, 30 Oct 2001 04:26:23 -0500
From: "Rajat Chadda" <rajat.chadda@wipro.com>
To: Matthieu Delahaye <delahaym@esiee.fr>
Cc: Sureshkumar Kamalanathan <skk@sasken.com>, linux-kernel@vger.kernel.org
Message-ID: <9737496333.9633397374@wipro.com>
Date: Tue, 30 Oct 2001 14:25:38 +0500
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: Re: How to write System calls?
X-Accept-Language: en
Content-Type: multipart/mixed; boundary="--14c0534a2b021778"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

----14c0534a2b021778
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Yes -- system calls can be implemented
as modules.
prog8.c is a module.
prog9.c is a user-space program.

In <asm/unistd.h> -- add
#define __NR_my_func            250 


----- Original Message -----
From: Matthieu Delahaye <delahaym@esiee.fr>
Date: Tuesday, October 30, 2001 2:41 pm
Subject: Re: How to write System calls?

> Hi,
> 
> First, I propose you to have a look on "Linux Kernel 2.4 Internals" 
> from 
> Tigran Aivazian. You can read it from the LDP at exact URL: 
> http://www.linuxdoc.org/LDP/lki/index.html
> In this, you'll probably see that syscalls are hardcoded (file 
> arch/xxx/kernel/entry.S  on your kernel tree).
> This means, AFAIK, you cannot implements a syscall function in a 
> module ;-)
> One other way is using  your modules to implements char drivers and 
> use 
> ioctl() as if it was yours syscalls. This method is generally 
> recommended to users who wants to implement new sayscalls.
> 
> 
> Am I wrong?
> 
> Regards,
> Matthieu
> 
> Sureshkumar Kamalanathan wrote:
> 
> >Hi All,
> >  Good day!
> >  I have 2.4.4 kernel.  I have to write some system calls for
> >interaction with the kernel from the userland.  Can any of you 
> tell me
> >where I can get the information regarding this?  
> >  I have the Linux Kernel Internals by Beck and others.  But it gives
> >the procedure only for 2.2.x.
> >  Moreover I need to implement these system calls as Loadable 
> modules.>  Any pointers in this regard will be highly appreciated 
> and I'll very
> >grateful!!
> >
> >  Thanks in advance,
> >
> >Regards,
> >Suresh.
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-
> kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-
> kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

----14c0534a2b021778
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rog8.c"

I2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgojaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CiNp
bmNsdWRlIDxsaW51eC9zeXMuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiAKZXh0ZXJuIHZvaWQg
KnN5c19jYWxsX3RhYmxlW107CiAKYXNtbGlua2FnZSBzdGF0aWMgdm9pZCBzeXNfbXlfZnVu
YygpOwogCnZvaWQgKm9sZF92YWw7CgogCmludAppbml0X21vZHVsZSgpCnsKICAgICAgICBw
cmludGsoIkFkZGluZyBteSBvd24gc3lzdGVtIGNhbGwgXG4iKTsKCW9sZF92YWwgPSAodm9p
ZCAqKSBzeXNfY2FsbF90YWJsZVsyNTBdOwogCiAgICAgICAgc3lzX2NhbGxfdGFibGVbMjUw
XSA9ICh2b2lkICopIHN5c19teV9mdW5jOwogCiAgICAgICAgcmV0dXJuIDA7Cn0KIAphc21s
aW5rYWdlIHN0YXRpYyB2b2lkIHN5c19teV9mdW5jKCkKewogICAgICAgIHByaW50aygiSSBh
bSBhIHdvcmtpbmcgc3lzdGVtIGNhbGwuXG4iKTsKfQogCnZvaWQKY2xlYW51cF9tb2R1bGUo
KQp7CiAgICAgICAgc3lzX2NhbGxfdGFibGVbMjUwXSA9IG9sZF92YWw7CglwcmludGsoIjwx
PiBSZXN0b3Jpbmcgc3lzX2NhbGxfdGFibGVcbiIpOwp9Cg==
----14c0534a2b021778
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rog9.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxsaW51eC91bmlzdGQuaD4KZXh0ZXJuIGxv
bmcgX19yZXM7Cgpfc3lzY2FsbDAodm9pZCxteV9mdW5jKTsKCm1haW4oKQp7CgkJCgkKCW15
X2Z1bmMoKTsKCXByaW50ZigiZ29pbmcgdG8gcHJpbnQgbXkgY2FsbFxuIik7CgoJcHJpbnRm
KCJieWUgYnllIFxuIik7Cgp9Cg==


----14c0534a2b021778
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

-----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
------------------------------------------------------------------------------------------------------------------------

----14c0534a2b021778--

