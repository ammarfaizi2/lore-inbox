Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272413AbRH3TKt>; Thu, 30 Aug 2001 15:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272415AbRH3TKa>; Thu, 30 Aug 2001 15:10:30 -0400
Received: from smtp8.us.dell.com ([143.166.224.234]:34829 "EHLO
	smtp8.us.dell.com") by vger.kernel.org with ESMTP
	id <S272413AbRH3TKY>; Thu, 30 Aug 2001 15:10:24 -0400
Date: Thu, 30 Aug 2001 14:10:42 -0500 (CDT)
From: Michael E Brown <michael_e_brown@dell.com>
X-X-Sender: <mebrown@blap.linuxdev.us.dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <tytso@mit.edu>, <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blkgetsize64 ioctl
In-Reply-To: <E15cX66-0001cu-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108301403280.1213-200000@blap.linuxdev.us.dell.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1500554619-144202467-999198642=:1213"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1500554619-144202467-999198642=:1213
Content-Type: TEXT/PLAIN; charset=US-ASCII

Alan,
	Here is a patch that reserves the 108 and 109 ioctl numbers for
get/set last sector. This patch has already been merged into the ia64
tree, and is currently necessary in order to support the EFI GPT
partitioning scheme on ia64. It is also in the Red Hat kernel tree. I had
assumed that somebody at Red Hat would have forwarded it to you.

	Please apply.

	If you would consider the rest of the patch that implements the
ioctls, I can send you that as well.
--
Michael


On Thu, 30 Aug 2001, Alan Cox wrote:

> > On Thu, Aug 30, 2001 at 01:12:07PM -0400, Ben LaHaise wrote:
> > > No, that's not what's got me miffed.  What is a problem here is that an
> > > obvious next to use ioctl number in a *CORE* kernel api was used without
> > > reserving it.  AND PEOPLE SHIPPED IT!  I for one don't go about shipping
> > > new ABIs without reserving at least a placeholder for it in the main
> > > kernel (or stating that the code is not bearing a fixed ABI).  If the
> > > ioctl # was in the main kernel, this mess would never have happened even
> > > with the accidental shipping of the patch in e2fsprogs.
> >
> > ... and for my part, I included the patch in e2fsprogs because Ben
> > sent me the patch, saying that people would want to test it, and I
> > assumed he had already reserved the ioctl in the kernel.  I should
> > have checked first....
>
> Follow the rule I use with Linus - never send proposed changes you dont
> mean to be merged in a compilable form
>
> On this subject I think it would be good to get the security() syscall
> allocated now that folks are using the LSM framework for real stuff - even
> the NSA stuff
>
> Alan
>

-- 
Michael Brown
Linux OS Development
Dell Computer Corp

  If each of us have one object, and we exchange them,
     then each of us still has one object.
  If each of us have one idea,   and we exchange them,
     then each of us now has two ideas.


---1500554619-144202467-999198642=:1213
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch-getlastsector-20010213
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0108301410420.1213@blap.linuxdev.us.dell.com>
Content-Description: patch-getlastsector
Content-Disposition: attachment; filename=patch-getlastsector-20010213

ZGlmZiAtcnVQIGxpbnV4L2luY2x1ZGUvbGludXgvZnMuaCBsaW51eC1pb2N0
bC9pbmNsdWRlL2xpbnV4L2ZzLmgNCi0tLSBsaW51eC9pbmNsdWRlL2xpbnV4
L2ZzLmgJVHVlIEphbiAzMCAwMToyNDo1NiAyMDAxDQorKysgbGludXgtaW9j
dGwvaW5jbHVkZS9saW51eC9mcy5oCVR1ZSBGZWIgMTMgMTE6MDg6NDMgMjAw
MQ0KQEAgLTE4MCw2ICsxODAsOCBAQA0KIC8qIFRoaXMgd2FzIGhlcmUganVz
dCB0byBzaG93IHRoYXQgdGhlIG51bWJlciBpcyB0YWtlbiAtDQogICAgcHJv
YmFibHkgYWxsIHRoZXNlIF9JTygweDEyLCopIGlvY3RscyBzaG91bGQgYmUg
bW92ZWQgdG8gYmxrcGcuaC4gKi8NCiAjZW5kaWYNCisjZGVmaW5lIEJMS0dF
VExBU1RTRUNUICBfSU8oMHgxMiwxMDgpIC8qIGdldCBsYXN0IHNlY3RvciBv
ZiBibG9jayBkZXZpY2UgKi8NCisjZGVmaW5lIEJMS1NFVExBU1RTRUNUICBf
SU8oMHgxMiwxMDkpIC8qIGdldCBsYXN0IHNlY3RvciBvZiBibG9jayBkZXZp
Y2UgKi8NCiANCiANCiAjZGVmaW5lIEJNQVBfSU9DVEwgMQkJLyogb2Jzb2xl
dGUgLSBrZXB0IGZvciBjb21wYXRpYmlsaXR5ICovDQo=
---1500554619-144202467-999198642=:1213--
