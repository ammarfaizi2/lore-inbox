Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbQKGDTw>; Mon, 6 Nov 2000 22:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130815AbQKGDTo>; Mon, 6 Nov 2000 22:19:44 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:15626 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129716AbQKGDTi>;
	Mon, 6 Nov 2000 22:19:38 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 Oops 
In-Reply-To: Your message of "Mon, 06 Nov 2000 23:03:44 BST."
             <20001106230344.C992@iapetus.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Nov 2000 14:19:05 +1100
Message-ID: <9731.973567145@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000 23:03:44 +0100, 
Frank van Maarseveen <F.vanMaarseveen@inter.NL.net> wrote:
>First a firewall is installed (ppp0). Starting the network (eth0/lo only. ppp0 is
>nonexistent at this point) gives the following Oops:
>Nov  6 22:20:25 iapetus kernel: EIP:    0010:[ipt_REJECT:__insmod_ipt_REJECT_O/lib/modules/2.4.0-test10-x23/kernel/n+-92757/96] 
>	[ipt_REJECT:__insmod_ipt_REJECT_O/lib/modules/2.4.0-test10-x23/kernel/n+-89253/96]

klogd has tried to convert the addresses and got it completely wrong,
leaving nothing useful for ksymoops.  Change /etc/rc.d/init.d/syslog to
run klogd as "klogd -x", restart klogd, reproduce the problem and run
the result through ksymoops.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
