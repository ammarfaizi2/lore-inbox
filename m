Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131522AbQLJX7y>; Sun, 10 Dec 2000 18:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131528AbQLJX7o>; Sun, 10 Dec 2000 18:59:44 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:35589 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S131522AbQLJX7Z>;
	Sun, 10 Dec 2000 18:59:25 -0500
Message-Id: <200012101638.eBAGcuJ16062@sleipnir.valparaiso.cl>
To: Keith Owens <kaos@ocs.com.au>
Cc: Alan.Cox@linux.org, linux-kernel@vger.kernel.org
Subject: Re: Checking for incorrect MODULE_PARM 
In-Reply-To: Your message of "Sun, 10 Dec 2000 23:06:10 +1100."
             <18434.976449970@ocs3.ocs-net> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 10 Dec 2000 13:38:56 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> said:
> modutils 2.3.22 does more rigorous checking of MODULE_PARM entries and
> has already found several cases where MODULE_PARM(x) is used but the
> corresponding variable 'x' is not defined.  These are module coding
> bugs that were previously hidden.  Run this script to do a quick check
> of all your modules against modutils 2.3.22.  Run as any user, does not
> have not be root.
> 
> for i in $(/sbin/modprobe -l)
> do
> 	(echo -e "\n" $i ; /sbin/modinfo -p $i) > /var/tmp/modinfo
> 	grep warning /var/tmp/modinfo > /dev/null && cat /var/tmp/modinfo
> done

With 2.2.18pre27 on i686 I get:

 /lib/modules/2.2.18/ipv4/ip_masq_user.o
warning: symbol for parameter ports not found
ports int array (min = 1, max = 12)
debug int

Hope this helps a bit.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
