Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLQATg>; Sat, 16 Dec 2000 19:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbQLQAT0>; Sat, 16 Dec 2000 19:19:26 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:37134 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130017AbQLQATK>;
	Sat, 16 Dec 2000 19:19:10 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: John Covici <covici@ccs.covici.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too problem in 2.2.18 
In-Reply-To: Your message of "Sat, 16 Dec 2000 18:31:28 CDT."
             <Pine.LNX.4.21.0012161828180.628-100000@ccs.covici.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Dec 2000 10:48:37 +1100
Message-ID: <31453.977010517@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2000 18:31:28 -0500 (EST), 
John Covici <covici@ccs.covici.com> wrote:
>Hi.  I have a RealTech 8139 Ethernet card and I am using kernel
>2.2.18.  I tried to use the new driver 8139too as a module, but when
>doing an insmod or modprobe on the module I got "symbol forparameter
>debug not found".  There was nothing obvious in the module source, so
>any assistance would be appreciated.

The module has MODULE_PARM(debug) but debug is not defined.  Strictly
speaking the module should be fixed by Alan Cox has asked for modutils
to only issue a warning instead of an error for this type of bug.
modutils 2.3.23 has just been released with this change.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
