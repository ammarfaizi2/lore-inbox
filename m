Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289381AbSAJKok>; Thu, 10 Jan 2002 05:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289382AbSAJKoU>; Thu, 10 Jan 2002 05:44:20 -0500
Received: from mario.gams.at ([194.42.96.10]:58386 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S289381AbSAJKoL> convert rfc822-to-8bit;
	Thu, 10 Jan 2002 05:44:11 -0500
Message-Id: <200201101044.g0AAi6006890@frodo.gams.co.at>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C undefined behavior fix 
In-Reply-To: <20020109204043.T1027-100000@gerard> 
In-Reply-To: Your message of "Wed, 09 Jan 2002 20:47:15 +0100."
             <20020109204043.T1027-100000@gerard> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 10 Jan 2002 11:44:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020109204043.T1027-100000@gerard>, G rard Roudier wrote:
>On Tue, 8 Jan 2002, J.A. Magallon wrote:
>> On 20020107 jtv wrote:
>> >
>> >Let's say we have this simplified version of the problem:
>> >
>> >	int a = 3;
>> >	{
>> >		volatile int b = 10;
>>
>>     >>>>>>>>> here b changes
>
>Hmmm...
>Then your hardware is probably broken or may-be you are dreaming. :-)

No, it may be e.g. a Rx/Tx-register in a standard UART chip, which is
memory-mapped at some address. Actually reading and writing the same
address then would get different registers in the hardware. Reading
two times may get different values.
You would actually access this register through a "volatile char *" 
but that's not a significant difference to the concept of "volatile", 
so I see above as a simple example (and not as an optimizer-guru's 
discussion subject "can we optimize just this volatile expression in 
that context").

>There is nothing in this code that requires the compiler to allocate
>memory for 'b'. You just invent the volatile constant concept. :)

Nope, this existed before as jtv@xs4all.nl explained correctly.

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


