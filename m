Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129909AbQLKLgr>; Mon, 11 Dec 2000 06:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130012AbQLKLgh>; Mon, 11 Dec 2000 06:36:37 -0500
Received: from [203.116.59.242] ([203.116.59.242]:10502 "HELO
	pisces.starnet.gov.sg") by vger.kernel.org with SMTP
	id <S129909AbQLKLgU>; Mon, 11 Dec 2000 06:36:20 -0500
Message-ID: <006901c06362$4e1333c0$050010ac@starnet.gov.sg>
From: "Corisen" <csyap@starnet.gov.sg>
To: "Keith Owens" <kaos@ocs.com.au>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <1186.976526843@ocs3.ocs-net>
Subject: Re: warning during make modules 
Date: Mon, 11 Dec 2000 19:05:42 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

Thanks for your reply. The below mentioned warning messages where displayed
while using modutils 2.3.22. Guess I need to apply the patch you mentioned
to removed all the anonying messages.

As I've not applied any patch before, pls advise where should I download the
patch and the instructions for patching pls.

Thanks.


----- Original Message -----
From: Keith Owens <kaos@ocs.com.au>
To: Corisen <csyap@starnet.gov.sg>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, December 11, 2000 5:27 PM
Subject: Re: warning during make modules


> On Mon, 11 Dec 2000 17:15:53 +0800,
> "Corisen" <csyap@starnet.gov.sg> wrote:
> >i'm compiling kernel 2.4.0-test11 uder RH7. i've changed the CC= line to
use
> >kgcc, executed "make clean" and "make mrproper". "make menuconfig" and
"make
> >dep" went smoothly. however during the "make modules" process, several
> >warning messages (shown below) appeared:
> >
> >{standard input}: Assembler messages:
> >{standard input}:8: Warning: Ignoring changed section attributes for
> >.modinfo
> >
> >pls kindly advise how can i resolve the warning messages, or can i can
> >safely igonre the warning messages?
>
> You can safely ignore the messages.  But if they get too annoying,
> upgrade to modutils >= 2.3.19 (current is 2.3.22) and apply this patch.
>
> Index: 0-test12-pre7.1/include/linux/module.h
> --- 0-test12-pre7.1/include/linux/module.h Thu, 07 Dec 2000 09:20:04 +1100
kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3.1.1 644)
> +++ 0-test12-pre7.2(w)/include/linux/module.h Mon, 11 Dec 2000 20:26:22
+1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3.1.2 644)
> @@ -247,12 +247,6 @@ static const struct gtype##_id * __modul
>    __attribute__ ((unused)) = name
>  #define MODULE_DEVICE_TABLE(type,name) \
>    MODULE_GENERIC_TABLE(type##_device,name)
> -/* not put to .modinfo section to avoid section type conflicts */
> -
> -/* The attributes of a section are set the first time the section is
> -   seen; we want .modinfo to not be allocated.  */
> -
> -__asm__(".section .modinfo\n\t.previous");
>
>  /* Define the module variable, and usage macros.  */
>  extern struct module __this_module;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
