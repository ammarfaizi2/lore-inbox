Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVJFRac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVJFRac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVJFRac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:30:32 -0400
Received: from pm2.irt.drexel.edu ([144.118.29.82]:37613 "EHLO
	smtp.mail.drexel.edu") by vger.kernel.org with ESMTP
	id S1751247AbVJFRab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:30:31 -0400
Message-ID: <43455F33.7020102@drexel.edu>
Date: Thu, 06 Oct 2005 13:30:27 -0400
From: "Justin R. Smith" <jsmith@drexel.edu>
Organization: Drexel University
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050908)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Instability in kernel version 2.6.12.5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently converted my web server from FreeBSD to Gentoo Linux and am 
running the 'vanilla' kernel, version 2.5.12.5 (the latest vanilla 
kernel one can emerge from Gentoon without hacking the package.keywords 
file).

Info on my system:
--------------------------------------------------------------------------------
Linux vorpal.math.drexel.edu 2.6.12.5 #1 SMP Wed Oct 5 16:04:20 EDT 2005 
i686 In
tel(R) Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux
 
Gnu C                  3.3.6
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.0
e2fsprogs              1.38
reiserfsprogs          3.6.19
reiser4progs           line
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   068
Modules Loaded         ipt_LOG ipt_state iptable_nat lp snd_pcm_oss 
snd_mixer_os
s snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device e1000 
snd_intel8x0 snd_a
c97_codec snd_pcm snd_timer snd soundcore snd_page_alloc intel_agp 
iptable_mangl
e iptable_filter ipt_ttl ipt_tos ipt_tcpmss ipt_sctp ipt_recent 
ipt_realm ipt_pk
ttype ipt_owner ipt_multiport ipt_mark ipt_mac ipt_limit ipt_length 
ipt_iprange 
ipt_hashlimit ipt_esp ipt_ecn ipt_dscp ipt_comment ipt_ah ipt_addrtype 
ipt_TOS i
pt_MARK ipt_ECN ipt_DSCP ipt_CLASSIFY arptable_filter arpt_mangle 
arp_tables ip_
conntrack ip_tables
------------------------------------------------------------

Additional info: I'm running a firewall that closes all ports except 22, 
80, 443 and high ports (so I can ftp).

After running for 24 hours, I discovered that the system was 'funky'.

funky=

1. the clock is frozen at about 2331 the previous night. Setting it is 
possible, but it remains frozen at whatever time one set it to.

2. Any X app one starts hangs.

3. Many operations take an extraordinarily long time. Rebooting the 
system too > 30 minutes (all spent shutting down. The restart was at the 
normal speed).


Examining the system logs disclosed that someone attempted to hack my 
system at 2331 (the time the clock was frozen at) by trying to initiate 
about 200 ssh connections with randomly generated user ids over a very 
short time (a few seconds).


I can easily modify the firewall to block the incoming connections, but 
this strikes me as showing an instability in the Linux kernel: 
initiating a large number of failed ssh connections should not be able 
to corrupt the kernel.

Any suggestions?


Thank you!
