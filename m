Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129430AbQJ3OIs>; Mon, 30 Oct 2000 09:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129470AbQJ3OIi>; Mon, 30 Oct 2000 09:08:38 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:64524 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129430AbQJ3OIT>;
	Mon, 30 Oct 2000 09:08:19 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux_developer@hotmail.com (Linux Kernel Developer),
        linux-kernel@vger.kernel.org
Subject: Re: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17 
In-Reply-To: Your message of "Mon, 30 Oct 2000 14:02:38 -0000."
             <E13qFWK-0006uI-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 01:08:13 +1100
Message-ID: <4793.972914893@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 14:02:38 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> As part of the 2.5 kbuild redesign, symbol versions will be completely
>> redone.  One of the things on my todo list is to detect this mismatch.
>> There are some problems in doing that which I may or may not be able to
>> overcome, but if the field names are different between C and C++ then I
>> can never detect this mismatch correctly.
>
>The symbol generation code never sees the C++ names, never will and never can.
>I still don't see any problem.

2.4 symbol generation code never sees the C++ names, 2.5 code might.
To detect a mismatch between kernel headers and the module version
file, I have to generate the checksum for the consumer of the symbol
(C++) as well as the generator of the symbol (C) and compare them.

There are issues involving partially defined structures which might
make this impossible to do, although I have some ideas on that front.
But if kernel code uses C names and module code uses C++ names there
will always be a spurious mismatch.  That would prevent symbol versions
from picking up some user errors.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
