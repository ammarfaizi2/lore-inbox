Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRFMNlj>; Wed, 13 Jun 2001 09:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbRFMNl3>; Wed, 13 Jun 2001 09:41:29 -0400
Received: from mailrelay.bluelabs.se ([194.17.38.34]:28421 "HELO
	mailrelay.bluelabs.se") by vger.kernel.org with SMTP
	id <S262389AbRFMNlT> convert rfc822-to-8bit; Wed, 13 Jun 2001 09:41:19 -0400
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
From: Magnus Sandberg <Magnus.Sandberg@bluelabs.se>
Subject: Re: Changing CPU Speed while running Linux
In-Reply-To: Your message of "Wed, 13 Jun 2001 14:21:37 BST."
             <3B2768E1.2B7E064C@redhat.com>
In-Reply-To: <20010613143536.A1323@iitb.fhg.de> <3B2768E1.2B7E064C@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Wed, 13 Jun 2001 15:41:11 +0200
Message-Id: <20010613134111.B126C17C7@mailrelay.bluelabs.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a brand new Dell Inspiron 8000, laptop. It can run in 700 MHz or
850 MHz. The manual says that the machine/BIOS switches speed dependent on 
CPU load. I have not installed Linux yet, but it works with Win2000.

It is also possible to force the BIOS to one speed if the OS don't like 
speed changes.

Would Linux accept sudden changes of CPU clock rate or is it only the the OS 
initiate the change of speed it is accepted?

I agree with you that it should be a generic thing. I guess that more and 
more laptops will get dual-speed CPUs.


                                  _\\|//_
                                  (-0-0-)
/-------------------------------ooO-(_)-Ooo------------------------------\
| Magnus Sandberg                    Email: Magnus.Sandberg@bluelabs.se  |
| Network Engineer, BlueLabs AB                  http://www.bluelabs.se/ |
| Phone: +46-8-470 2155                             FAX: +46-8-470 2199  |
\------------------------------------------------------------------------/
                                  ||   ||
                                 ooO   Ooo



 ----- On 13th of June 2001 Arjan van de Ven wrote; -----

Geggus wrote:
> 
> Hi there,
> 
> on my Elan410 based System it is very easy to change the CPU clock speed
> by means od two outb commands.
> 
> I was wondering, if it does some harm to the Kernel if the CPU is
> reprogrammed using a different CPU clock speed, while the system is up and
> running.

I have a module for the K6 PowerNow which allows you to do

echo 450 > /proc/sys/cpu/0/frequency

and does the right thing wrt udelay / bogomips etc..
I can dig it out if you want.. sounds like this should be a more generic
thing.

Greetings,
  Arjan van de Ven


