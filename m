Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUDEUKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 16:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbUDEUKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 16:10:22 -0400
Received: from hoemail1.lucent.com ([192.11.226.161]:16379 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262398AbUDEUKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 16:10:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16497.48378.82191.330004@gargle.gargle.HOWL>
Date: Mon, 5 Apr 2004 16:09:30 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Timothy Miller <miller@techsource.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
In-Reply-To: <20040405175940.94093.qmail@web40509.mail.yahoo.com>
References: <4071A036.4050003@techsource.com>
	<20040405175940.94093.qmail@web40509.mail.yahoo.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Sergiy" == Sergiy Lozovsky <serge_lozovsky@yahoo.com> writes:

Sergiy> Basically there are two reasons.

Sergiy> 1. Give system administrator possibility to change security
Sergiy> policy easy enough without C programminig inside the kernel
Sergiy> (we should not expect system administartor to be a kernel
Sergiy> guru). Language of higher lavel make code more compact (C - is
Sergiy> too low level, that's why people use PERL for example or
Sergiy> LISP). Lisp was chosen because of very compact VM - around
Sergiy> 100K.

Why in god's name does this need to be in the kernel?  This is purely
a userspace issue, and the tool for managing the security policy
should be completely in userspace.  

Under this design, /bin/ls would be a kernel module, and not a
userspace tool!   

If you ever want to even think about getting this project into the
kernel, you'll have to re-design what you're doing here, since there's
absolutely no need for anything like this in the kernel.

Sergiy> 2. Protect system from bugs in security policy created by
Sergiy> system administrator (user).  

C'mon, GIGO will kill you from user space or from kernel space.  What
makes you think LISP will protect you?  

Sergiy> LISP interpreter is a LISP Virtual Machine (as Java VM). So
Sergiy> all bugs are incapsulated and don't affect kernel.

Then *WHY* does the LISP interpreter need to be in the kernel in the
first place?  Hint, you just said you wanted to protect the kernel...

Sergiy> Even severe bugs in this LISP kernel module can cause
Sergiy> termination of user space application only (except of stack
Sergiy> overflow - which I can address). LISP error message will be
Sergiy> printed in the kernel log.

Hah!  You just gave the number one reason why you don't want or need a
LISP interpreter in the kernel yourself.  

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
