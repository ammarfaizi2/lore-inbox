Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbTFFAWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 20:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbTFFAWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 20:22:42 -0400
Received: from izar.unm.edu ([129.24.9.34]:9602 "HELO izar.unm.edu")
	by vger.kernel.org with SMTP id S265263AbTFFAWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 20:22:40 -0400
To: linux-kernel@vger.kernel.org
Subject: recompiling RH9 with SCSI driver
Date: Thu, 05 Jun 2003 18:36:12 -0600
From: Daniel Sheltraw <sheltraw@unm.edu>
Message-ID: <1054859772.3edfe1fcaaa6e@webdjn.unm.edu>
X-Mailer: UNM WebMail v1.1.10 24-January-2003
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: 128.218.188.123
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello kernel list

I knowm this is not really a kernel problem but I have been unable
to get this problem solved on other lists. I am having trouble
building a new 2.4.20 kernel on a machine running RedHat9 and
it appears that the problem has something to do with the mptbase
module (scsi module?).

The machine is a Dell Precision 350 machine and lspci tells me this
about my SCSI controller:

02:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
02:07.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)


I am trying to recompile my kernel but after when doing a "make install"
I get the folloeing error message:

sh -x ./install.sh 2.4.20-rthal5 bzImage /usr/src/linux-2.4.20/System.map ""
+ '[' -x /root/bin/installkernel ']'
+ '[' -x /sbin/installkernel ']'
+ exec /sbin/installkernel 2.4.20-rthal5 bzImage
/usr/src/linux-2.4.20/System.map ''
No module mptbase found for kernel 2.4.20-rthal5
mkinitrd failed
make[1]: *** [install] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.20/arch/i386/boot'
make: *** [install] Error 2

There does not exist a /lib/modules directory for my new modules
and it looks like "make install" can't find the mptbase driver.
Does any one know how to fix this?

Thanks a bunch,
Daniel


-- 
redhat-list mailing list
unsubscribe mailto:redhat-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/redhat-list

----- End forwarded message -----
