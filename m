Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbULQJKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbULQJKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 04:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbULQJKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 04:10:51 -0500
Received: from piglet.wetlettuce.com ([82.68.149.69]:21120 "EHLO
	piglet.wetlettuce.com") by vger.kernel.org with ESMTP
	id S262777AbULQJKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 04:10:44 -0500
Message-ID: <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com>
Date: Fri, 17 Dec 2004 09:10:14 -0000 (GMT)
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
From: "Mark Broadbent" <markb@wetlettuce.com>
To: <mpm@selenic.com>
In-Reply-To: <20041216211024.GK2767@waste.org>
References: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com>
        <20041216211024.GK2767@waste.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
Reply-To: markb@wetlettuce.com
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner: Mail is clear of Viree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matt Mackall said:
> On Thu, Dec 16, 2004 at 04:20:02PM -0000, Mark Broadbent wrote:
>> Hi,
>>
>> I'm having problem using ethereal/tcpdump in conjunction with the
>> netconsole (built as a module).  If the netconsole is loaded and I try
>> to launch tcpdump on the same interface as the netconsole is
>> transmitting I get a hard lock-up.  The following commands can
>> consistently do this: # tcpdump -i eth0
>> eth0: Promiscuous Mode Entered
>> <... normal output ...>
>> ^C
>> # modprobe netconsole
>> # tcpdump -i eth0
>> eth0: Promiscuous Mode Entered
>> <4>NMI Watchdog detected LOCKUP
>
> Joy. Can you try it on your other interface to see if it's
> driver-specific?

Tried using eth1 which is using the r8169 but it doesn't support polling. 
I also tried with 2.6.10-rc3-bk10 but it still doesn't support polling. 
Also it still locks up using eth0 (the tulip driver) with 2.6.10-rc3-bk10.
Thanks
Mark

-- 
Mark Broadbent <markb@wetlettuce.com>
Web: http://www.wetlettuce.com



