Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131467AbQKPUzD>; Thu, 16 Nov 2000 15:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbQKPUyx>; Thu, 16 Nov 2000 15:54:53 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:26122 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131467AbQKPUyn>;
	Thu, 16 Nov 2000 15:54:43 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Local root exploit with kmod and modutils > 2.1.121 
In-Reply-To: Your message of "Thu, 16 Nov 2000 16:04:23 -0000."
             <E13wRWU-0007yG-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Nov 2000 07:24:36 +1100
Message-ID: <4328.974406276@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000 16:04:23 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> request_module has the same effect as running suid.  dev_load() can
>> take the interface name and pass it to modprobe unchanged and modprobe
>> does not verify its input, it trusts root/kernel.
>
>Then dev_load is being called the wrong way. In older kernels we explicitly
>only did a dev_load with user passed names providing suser() was true.

ping6 -I module_name.  ping6 is setuid, it passes the interface name to
the kernel while it holds root privileges, suser() == true.  It is
not reasonable to expect setuid programs to know that Linux does
something special with some parameters when no other O/S has that
"feature".

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
