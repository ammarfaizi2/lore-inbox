Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267001AbUAXTgP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 14:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267002AbUAXTgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 14:36:15 -0500
Received: from village.ehouse.ru ([193.111.92.18]:29704 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S267001AbUAXTgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 14:36:12 -0500
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: "Feldman, Scott" <scott.feldman@intel.com>,
       "Petr Sebor" <petr@scssoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.x] e1000: NETDEV WATCHDOG: eth0: transmit timed out
Date: Sat, 24 Jan 2004 22:36:03 +0300
User-Agent: KMail/1.5.4
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229D92@orsmsx402.jf.intel.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102229D92@orsmsx402.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401242236.03765.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Scott, Petr,

On Saturday 24 January 2004 01:28, Feldman, Scott wrote:
> > since we have upgraded cabling on our network and transfer
> > speeds increased a little bit, we are experiencing very often
> > situations where the Intel PRO/1000 nics just stop responding
> > and network dies for a while. Local console works, there are
> > no more error messages other than (when the eth0 comes to a
> > life again):
> >
> > NETDEV WATCHDOG: eth0: transmit timed out
> > e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
>
> Petr, I need you to try something.  Get ethtool 1.8
> (sf.net/projects/gkernel) and turn off TSO:
>
>   # ethtool -K eth0 tso off
>
> If you now longer see NETDEV WATCHDOG's, I have a next step.  More on
> that later.
I have had exactly the same problem with 2.6.{0,1} kernels:
"NETDEV WATCHDOG: eth0: transmit timed out"
where eth0 is:
"03:07.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)".
The only difference is that my eth0 is at 100 Mbps Full Duplex.
And yes, in my case this problem was solved by `ethtool -K eth0 tso off`.

>
> -scott
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc

