Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTK3Lgz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 06:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbTK3Lgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 06:36:55 -0500
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:20459 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S264899AbTK3Lgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 06:36:54 -0500
Date: Sun, 30 Nov 2003 12:36:56 +0100
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 -- Failed to open /dev/ttyS0: No such device
Message-ID: <20031130113656.GA28437@finwe.eu.org>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
References: <20031130071757.GA9835@node1.opengeometry.net> <20031130102351.GB10380@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130102351.GB10380@outpost.ds9a.nl>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

> > Does anyone have modem working in 2.6.0-test11?
> > I have external modem connected to /dev/ttyS0 (COM1).  Kernel
> > 2.6.0-test11 give me
> Double check your .config and attach it if in doubt.
> Something like grep SERIAL .config might be enlightning.

It reminds me, that I had to add serial to the list of modules
loading at start to get back access to /dev/ttyS* 
(while upgrading from -test9 to -test10). 

install serial /sbin/modprobe 8250 && { /etc/init.d/setserial modload  }

Linux finwe 2.6.0-test11 #5 Fri Nov 28 01:22:33 CET 2003 i686 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre3
e2fsprogs              1.35-WIP
jfsutils               1.1.4
xfsprogs               2.6.0
PPP                    2.4.2b3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         isofs nls_cp852 smbfs ppp_deflate zlib_deflate zlib_inflate bsd_comp parport_pc lp parport snd_seq_midi snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_ens1371 snd_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer snd_ac97_codec gameport snd soundcore ppp_async ppp_generic slhc ip_nat_ftp ipt_multiport ipt_state ipt_pkttype ipt_LOG ipt_limit ipt_REJECT iptable_nat iptable_filter ip_tables ip_conntrack_ftp ip_conntrack rtc 8139too mii crc32 uhci_hcd ohci_hcd nls_iso8859_2 nls_cp437 vfat fat 8250 serial_core psmouse thermal processor fan

bye,

-- 
Jacek Kawa  **I stepped into an avalanche,it covered up my soul [L.Cohen]**
