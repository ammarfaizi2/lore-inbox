Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUBPGFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 01:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUBPGFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 01:05:18 -0500
Received: from aragorn.schlenn.net ([195.177.220.21]:26248 "EHLO
	aragorn.schlenn.net") by vger.kernel.org with ESMTP id S265211AbUBPGFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 01:05:04 -0500
Date: Sun, 15 Feb 2004 22:22:42 +0100
From: Michael Schlenstedt <Michael-ml-kernel@schlenn.net>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Cc: jjciarla@raiz.uncu.edu.ar
Subject: PROBLEM: /proc/sys/net/ipv4/ip_dynaddr does not work correctly
Message-ID: <20040215212241.GA2752@schlenn.net>
Mail-Followup-To: Michael Schlenstedt <Michael-ml-kernel@schlenn.net>,
	Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	jjciarla@raiz.uncu.edu.ar
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux (2.4.21-166-athlon)
Organization: http://www.schlenn.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!


[1.] One line summary of the problem:

/proc/sys/net/ipv4/ip_dynaddr does not work correctly in debug-mode.


[2.] Full description of the problem/report:

I've recognized that the debug-mode ("2") with
/proc/sys/net/ipv4/ip_dynaddr does not work correctly. In fact, if I do
a "echo 2 > /proc/sys/net/ipv4/ip_dynaddr", nothing happens. There are no
messages in the syslog, and there is no function of ip_dynaddr at all.

If I use "echo 1 > /proc/sys/net/ipv4/ip_dynaddr", it works fine, of
course without any debugging messages.

So it seems that the "2"-mode (debug output) does not work correctly
with newer kernels (tested with 2.4.21 and 2.4.24)


[3.] Keywords (i.e., modules, networking, kernel):

network, NAT, masquerading, dynamic ip


[4.] Kernel version (from /proc/version):

Linux version 2.4.24 (root@gandalf) (gcc version 2.95.4 20011002 (Debian
prerelease)) #3 SMP Sun Feb 15 10:43:15 CET 2004


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux gandalf 2.4.24 #3 SMP Sun Feb 15 10:43:15 CET 2004 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ppp_deflate zlib_deflate bsd_comp ppp_synctty
nfsd parport_pc lp parport ipt_multiport ipt_LOG ipt_limit ipt_unclean
iptable_mangle iptable_filter ipt_MASQUERADE ipt_REJECT iptable_nat
ipt_state ip_conntrack_ftp ip_conntrack ip_tables ppp_generic slhc fcpci
capi capifs kernelcapi capiutil printer uhci usbcore apm dmfe


[7.3.] Module information (from /proc/modules):

ppp_deflate             3008   0 (autoclean)
zlib_deflate           18048   0 (autoclean) [ppp_deflate]
bsd_comp                4032   0 (autoclean)
ppp_synctty             5760   0 (autoclean)
nfsd                   45920   4 (autoclean)
parport_pc             25320   1 (autoclean)
lp                      6528   0 (autoclean)
parport                24704   1 (autoclean) [parport_pc lp]
ipt_multiport            640   8 (autoclean)
ipt_LOG                 3360   8 (autoclean)
ipt_limit               1056   9 (autoclean)
ipt_unclean             6784   1 (autoclean)
iptable_mangle          2208   0 (autoclean) (unused)
iptable_filter          1760   1 (autoclean)
ipt_MASQUERADE          1504   0 (unused)
ipt_REJECT              3264  18
iptable_nat            16596   1 [ipt_MASQUERADE]
ipt_state                608  20
ip_conntrack_ftp        3936   0 (unused)
ip_conntrack           21428   3 [ipt_MASQUERADE iptable_nat ipt_state
ip_conntrack_ftp]
ip_tables              12032  12 [ipt_multiport ipt_LOG ipt_limit
ipt_unclean iptable_mangle iptable_filter ipt_MASQUERADE ipt_REJECT
iptable_nat ipt_state]
ppp_generic            23308   1 (autoclean) [ppp_deflate bsd_comp
ppp_synctty]
slhc                    4736   0 (autoclean) [ppp_generic]
fcpci                 531008   3
capi                   19360   8
capifs                  3584   1 [capi]
kernelcapi             30880   4 [fcpci capi]
capiutil               22464   0 [kernelcapi]
printer                 7776   0
uhci                   25320   0 (unused)
usbcore                60256   1 [printer uhci]
apm                     9692   0 (unused)
dmfe                   12348   1


Bye,
Michael

