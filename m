Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264482AbRFXUQ1>; Sun, 24 Jun 2001 16:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264483AbRFXUQR>; Sun, 24 Jun 2001 16:16:17 -0400
Received: from ohiper1-198.apex.net ([209.250.47.213]:31751 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S264482AbRFXUQB>; Sun, 24 Jun 2001 16:16:01 -0400
Date: Sun, 24 Jun 2001 15:14:42 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Matthias Papesch <MPapesch@gmx.de>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: 2.4.[5 - 6pre5] boomerang_start_xmit -> kernel panic
Message-ID: <20010624151442.A8756@hapablap.dyn.dhs.org>
In-Reply-To: <21827.993371691@www52.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <21827.993371691@www52.gmx.net>; from MPapesch@gmx.de on Sun, Jun 24, 2001 at 10:34:51AM +0200
X-Uptime: 3:05pm  up 1 day, 13:47,  1 user,  load average: 1.10, 1.08, 1.09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I too have been experiencing this on a gateway for a DSL modem.  The
backtrace is almost exactly the same.  On this machine, the bug results
in an "Aieee:  Killing Interrupt Handler".  I have to manually copy the
oops, and as such I copied only the backtrace, and parts of it may be
incorrect.  I've attached it anyway, just in case it helps someone.

I would really like to see this fixed, and so am willing to help
diagnose and test any patches.

On Sun, Jun 24, 2001 at 10:34:51AM +0200, Matthias Papesch wrote:
> Hi,
> 
> I've been repeatedly experiencing the same kernel panic. It happens on a
> computer that acts as an isdn internet gateway for my home network. Two other
> computers, that have the same kernel and NICs but don't do ip-forwarding have
> not crashed so far.
> 
> * NIC: 3com 3c905B-TX (PCI)
> * ISDN: Teles 16.3 (ISA)
> 
> The calling stack always looked pretty much the same (see Attachment).
> The panic occurs, when multiple internet connections are in use. 
> 
> 
> Regards,
> Matthias
> 
> PS: Please put into CC, as I am not subscribed to the list. 
> I've skimmed over the last two weeks of the archive, but did not find
> anything that looked similar to me.
> 
>  


-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=greg-oops

ksymoops 2.3.4 on i586 2.4.5-ac2.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map-2.4.5 (specified)

Call Trace: [<c01aa00b>] [<c01aabb3>] [<c01ad416>] [<c01b0453>] [<c01b8bcd>] [<c01b1317>]  [<c01b633c>] [<c01b8b32>] [<c01b8b4c>] [<c01638a0>] [<c01b1317>] [<c01b62ed>] [<c01b633c>] [<c01b55d8>]  [<c01b524f>] [<c01b55d8>] [<c01b1317>] [<c01b5435>] [<c01b55d8>] [<c01ad9ab>] [<c0116190>] [<c0107ef2>]  [<c0106b20>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c01aa00b <skb_release_data+5f/70>
Trace; c01aabb3 <__pskb_pull_tail+2f/2d4>
Trace; c01ad416 <dev_queue_xmit+26/1e4>
Trace; c01b0453 <neigh_resolve_output+113/184>
Trace; c01b8bcd <ip_finish_output2+81/b4>
Trace; c01b1317 <nf_hook_slow+e3/124>
Trace; c01b633c <ip_forward_finish+0/54>
Trace; c01b8b32 <ip_finish_output+e2/e8>
Trace; c01b8b4c <ip_finish_output2+0/b4>
Trace; c01638a0 <nfsd_write+88/29c>
Trace; c01b1317 <nf_hook_slow+e3/124>
Trace; c01b62ed <ip_forward+19d/1ec>
Trace; c01b633c <ip_forward_finish+0/54>
Trace; c01b55d8 <ip_rcv_finish+0/1a8>
Trace; c01b524f <ip_rcv+13f/35c>
Trace; c01b55d8 <ip_rcv_finish+0/1a8>
Trace; c01b1317 <nf_hook_slow+e3/124>
Trace; c01b5435 <ip_rcv+325/35c>
Trace; c01b55d8 <ip_rcv_finish+0/1a8>
Trace; c01ad9ab <net_rx_action+13b/218>
Trace; c0116190 <do_softirq+40/64>
Trace; c0107ef2 <do_IRQ+a2/b0>
Trace; c0106b20 <ret_from_intr+0/20>


1 warning issued.  Results may not be reliable.

--uAKRQypu60I7Lcqm--
