Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQLKMhP>; Mon, 11 Dec 2000 07:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbQLKMhF>; Mon, 11 Dec 2000 07:37:05 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:35857 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129523AbQLKMgu>;
	Mon, 11 Dec 2000 07:36:50 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Corisen" <csyap@starnet.gov.sg>
cc: linux-kernel@vger.kernel.org
Subject: Re: warning during make modules 
In-Reply-To: Your message of "Mon, 11 Dec 2000 19:05:42 +0800."
             <006901c06362$4e1333c0$050010ac@starnet.gov.sg> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Dec 2000 23:06:18 +1100
Message-ID: <1671.976536378@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000 19:05:42 +0800, 
"Corisen" <csyap@starnet.gov.sg> wrote:
>Thanks for your reply. The below mentioned warning messages where displayed
>while using modutils 2.3.22. Guess I need to apply the patch you mentioned
>to removed all the anonying messages.
>
>As I've not applied any patch before, pls advise where should I download the
>patch and the instructions for patching pls.

The patch is in the original email, reproduced below.  It is against
linux-2.4.0-test12-pre7 but will fit -pre8 as well.  The Kernel-HOWTO
(part of the howto package) has a section on patching the kernel.

Index: 0-test12-pre7.1/include/linux/module.h
--- 0-test12-pre7.1/include/linux/module.h Thu, 07 Dec 2000 09:20:04 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3.1.1 644)
+++ 0-test12-pre7.2(w)/include/linux/module.h Mon, 11 Dec 2000 20:26:22 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3.1.2 644)
@@ -247,12 +247,6 @@ static const struct gtype##_id * __modul
   __attribute__ ((unused)) = name
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
-/* not put to .modinfo section to avoid section type conflicts */
-
-/* The attributes of a section are set the first time the section is
-   seen; we want .modinfo to not be allocated.  */
-
-__asm__(".section .modinfo\n\t.previous");
 
 /* Define the module variable, and usage macros.  */
 extern struct module __this_module;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
