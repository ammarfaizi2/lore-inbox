Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279190AbRKMVNz>; Tue, 13 Nov 2001 16:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279170AbRKMVM0>; Tue, 13 Nov 2001 16:12:26 -0500
Received: from modemcable058.33-200-24.mtl.mc.videotron.ca ([24.200.33.58]:4877
	"EHLO firewall.imaginary.lan") by vger.kernel.org with ESMTP
	id <S279156AbRKMVMV>; Tue, 13 Nov 2001 16:12:21 -0500
Date: Tue, 13 Nov 2001 16:17:34 -0500
From: Eric Preston <eric@linuxmontreal.com>
To: David Ranch <dranch@juniper.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.20 - Possible module symbol bug
Message-ID: <20011113161734.A10370@firewall.imaginary.lan>
In-Reply-To: <3BEC4122.4C4DFB32@juniper.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BEC4122.4C4DFB32@juniper.net>; from dranch@juniper.net on Fri, Nov 09, 2001 at 12:48:34PM -0800
X-Redundant: [drbones@drbones drbones]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> #depmod -a
> /lib/modules/2.2.20/scsi/ide-scsi.o: unresolved symbol(s)
> /lib/modules/2.2.20/block/loop.o: unresolved symbol(s)
> /lib/modules/2.2.20/ipv4/ip_masq_vdolive.o: unresolved symbol(s)
> /lib/modules/2.2.20/ipv4/ip_masq_quake.o: unresolved symbol(s)
> /lib/modules/2.2.20/ipv4/ip_masq_raudio.o: unresolved symbol(s)
> /lib/modules/2.2.20/ipv4/ip_masq_irc.o: unresolved symbol(s)
> /lib/modules/2.2.20/ipv4/ip_masq_ftp.o: unresolved symbol(s)
> /lib/modules/2.2.20/ipv4/ip_masq_user.o: unresolved symbol(s) 
> 
> #modprobe --debug ip_masq_ftp
> /lib/modules/2.2.20/ipv4/ip_masq_ftp.o: unresolved symbol ip_masq_new
> /lib/modules/2.2.20/ipv4/ip_masq_ftp.o: unresolved symbol ip_masq_put
> /lib/modules/2.2.20/ipv4/ip_masq_ftp.o: unresolved symbol ip_masq_listen
> /lib/modules/2.2.20/ipv4/ip_masq_ftp.o: unresolved symbol ip_masq_control_add
> /lib/modules/2.2.20/ipv4/ip_masq_ftp.o: unresolved symbol ip_masq_out_get 

I noticed the same problem when recently building 2.2.20,

Enable "prompt for experimental code"
And choose the appropriate masq options that now appear,
and the masq stuff goes away. Something to do with CONFIG_MASQUERADE_MOD
not being set, was in a hurry so i didn't bother to look into it more,

regards,
Eric

