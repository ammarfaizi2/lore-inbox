Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130275AbRB1RYg>; Wed, 28 Feb 2001 12:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130279AbRB1RY1>; Wed, 28 Feb 2001 12:24:27 -0500
Received: from alquanto.nextra.it ([193.43.2.90]:43762 "EHLO
	alquanto.nextra.it") by vger.kernel.org with ESMTP
	id <S130275AbRB1RYN>; Wed, 28 Feb 2001 12:24:13 -0500
Message-ID: <3A9D30B1.FC629CE1@nextra.it>
Date: Wed, 28 Feb 2001 18:09:05 +0100
From: Andrea Venturi <a.venturi@nextra.it>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x (also latitude)
Content-Type: multipart/mixed;
 boundary="------------998B62D326C3AC94906213D7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------998B62D326C3AC94906213D7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hi,

sorry to bother you all...

i would like to follow up this thread because, i have too this strange
effect that with kernel 2.4.2 i'm no more able to use the pcmcia
interface (and with 2.2.17 it was ok!).

i tried to make some troubleshooting to the best of my knowledge but i
lost myself when, last email, Jeff Lessem ended saying that, just using
lilo (and not grub) the problem went away.. but is he still speaking of
the pcmcia problem?

i am using:

- a dell latitude cpx h450  (bios a07)
- 256 MB of ram
- lilo (without any mem append option)
- with 2.2.17 pcmcia is working well
- with 2.4.2 and external pcmcia-cs 3.1.24 no (i have never been able to
load the i82365.o module)

you can find in attach my dmesg and the output of "lspci -vvxxx -s03:00"
that are my pci entries of the pcmcia adapter (hope not to be a mistake
posting a couple of small bin attach) and the relevant message is:

 Intel PCIC probe: PCI: Enabling device 00:03.0 (0000 -> 0002)
 PCI: Found IRQ 11 for device 00:03.0
 PCI: The same IRQ used for device 00:03.1
 PCI: The same IRQ used for device 00:07.2

   Bridge register mapping failed: check cb_mem_base setting not found.

 ....

i tried to add the cb_mem_base parameter loading pcmcia_core but  in the
pci_fixup.c source is commented out when you use a >= 2.3.24 kernel, so
this line fails:

  insmod pcmcia_core cb_mem_base=0x10000000

could someone kindly shed some light!?

sorry, i'm not subscribed to lkml so, please, cc. to me, otherwise, i
will check the answers on the ml archive.

thank you in advance

andrea venturi


> In your message of: Sat, 24 Feb 2001 11:55:07 CST, you write: 
> > 
> >Careful, you're overwriting ACPI data now (and using it as normal RAM). 
> 
> Hmm, I guess that would be bad. 
> 
> >Can you try one of a) LILO b) a fixed version of grub c) this patch ? 
> 
> I tried LILO and the problem did indeed go away when using that. I 
> guess I'll stick with LILO until Linux or grub (whichever is broken) 
> is fixed. There is just something appealing about a proper boot 
> console on a PC... 


-- 
andrea venturi - Nextra spa
a.venturi@nextra.it - +390516139246

--
"If a man speaks in the forest and there is no woman to hear him, 
 is he still wrong?"
--------------998B62D326C3AC94906213D7
Content-Type: application/octet-stream;
 name="ti1225.txt.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ti1225.txt.bz2"

QlpoOTFBWSZTWWQS2/sAA27fgAwwQG//9z+v/4o/79/wUAQeAAAAAHNGTEwATEYEaYEGIwTJ
gEYc0ZMTABMRgRpgQYjBMmARhzRkxMAExGBGmBBiMEyYBGHNGTEwATEYEaYEGIwTJgEYFUQg
QBGgnqYp6nqY1MT1M1PSNNNManqZPSaILEMXtO1sUaWxLSxVYqI4kiqYRm3KMkoC5IhC5KEQ
5SEiJTByO6kfvJqTilgmkqJLSYHgq3rL1z3vqtmmOadWpRHvZn2d6zFta37NblYsDRpjFVsT
DBRwJaTJVdDkQ72tdXBdf3v9XLkkvBR9Uo51FCyUJSlJ5zoXWZkcbB4pWaGpeucjzL3Ol61U
d7+T0GdgYvs5KObm1Jp8XtXKJRf5FXuS2NTQxaGTwcLMfdk/x+h+LqeVvdD4I5CERclEIhek
gUSI9aUPOmIb0t6RRMOZNpve2jQvUhHOREyhAj3KQVeYsilY9hVRJEydSV6UpI/VmdTY7HY0
tjpcTWztzhbm1Z3KF6SNbilRciZbknG7VBoZ2GBLJZcjFMRVKyTqO0wXuR+yrBLBcuUWWLKK
ONtZl69JZVciyyi9KkVSlRELJQ9T0v1OJ0Lj0L1GSPOvmZiXxVH9Pol3nzNhnPI6EsXelFEs
7pUf4loXpR83YSsesyKPm8FEdazrd6z6PIoj8HW+iKrkj+ELMBk71WpRedyVyUsVlUeCTF+T
erBveCXmT1lnWl50vq4oUdz+Xi5nSSlraH3fI62Y/Rtfk3Oxwul8DjiNrnGdRV1MXpXMlHiv
Z3sWVa1GDBqVhZZiWeMLlx8HYcDQlmb1XyUc75pWXw8rSo9Lsb16SV6ULMHSxdDtValnA4nC
owJcDS8WCNq9/xRk4Wxgvh7DEo2NLc+zFvdLJsTDS2vwSjme9VVmLOFQoqooj3MHufd3FyV7
BrbnqXuFLYqqwcraskUdD1MnKYuNk2NrJgo1uNRxNCy5KWRklLF8FzU+Kz3sG5oZO0yUQ4lz
QqwRU1C6GJg615g/NRwr2tUxYpZxe1OhG5evYNK5RcqqwLORnVWSzFzFrXMlVxwLkmtpaTYq
aCVWDlYqFGpoexof+LuSKcKEgyCW39g=
--------------998B62D326C3AC94906213D7
Content-Type: application/octet-stream;
 name="dmesg.txt.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg.txt.bz2"

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
AA==
--------------998B62D326C3AC94906213D7--

