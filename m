Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132230AbRAEPmq>; Fri, 5 Jan 2001 10:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRAEPmf>; Fri, 5 Jan 2001 10:42:35 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:64396 "EHLO
	nynews01.e-steel.com") by vger.kernel.org with ESMTP
	id <S129383AbRAEPmU>; Fri, 5 Jan 2001 10:42:20 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: kernel network problem ?
Date: 05 Jan 2001 10:42:14 -0500
Organization: e-STEEL Netops news server
Message-ID: <m3elyiroo9.fsf@shookay.e-steel.com>
In-Reply-To: <000d01c07724$8fa531f0$8900030a@nicolasp>
NNTP-Posting-Host: shookay.e-steel
X-Trace: nynews01.e-steel.com 978709263 3112 192.168.3.43 (5 Jan 2001 15:41:03 GMT)
X-Complaints-To: news@nynews01.e-steel.com
NNTP-Posting-Date: 5 Jan 2001 15:41:03 GMT
X-Newsreader: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have to take a look at ENC:
Explicit Congestion Notification (ECN) allows routers to notify
clients about network congestion, resulting in fewer dropped packets
and increased network performance. This option adds ECN support to the
Linux kernel, as well as a sysctl (/proc/sys/net/ipv4/tcp_ecn) which
allows ECN support to be disabled at runtime.

Note that, on the Internet, there are many broken firewalls which
refuse connections from ECN-enabled machines, and it may be a while
before these firewalls are fixed. Until then, to access a site behind
such a firewall (some of which are major sites, at the time of this
writing) you will have to disable this option, either by saying N now
or by using the sysctl.

You can disable it at runtime with:
echo 0 > /proc/sys/net/ipv4/tcp_ecn

nparpand@perinfo.com ("Nicolas Parpandet") writes:
> Hi all,
> 
> I'm testing 2.4 series for few weeks,
> even the last prerelease
> 
> I've seen stranges things  :
> 
> I cannot access to some ips adresses ! :
> in http or in smtp using "konqueror", "netscape",
> "mail",  "telnet 25".
> 
> I cannot login to hotmail (in the web page:http) 
> or send mail (smtp) to hotmail users (don't blame me !!)
> All the others network things works well, the network in general seems
> good only very few sites like hotmail doesn't works.
> 
> And only with 2.4 series !! not with 2.2 ...
> 
> maybe it's a glibc or kernel issue, I'dont know.
> I have an intel SMP motherboard connected to the net (cable) 
> with a PCI realtek 8019.
> 
> I didn't analyse packets sent. If somebody else have the
> same problems ...
> 
> Nicolas.
> 
> Sorry for my poor english.
> 
> PS: funny "bug" isn't it ? (hotmail !)
> PS2: thanks for all, very good job done, 
>       2.4 is very fast and seems stable.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
