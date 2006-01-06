Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWAFTet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWAFTet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWAFTet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:34:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6816 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932504AbWAFTes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:34:48 -0500
Date: Fri, 6 Jan 2006 11:34:45 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Rusty Russell <rusty@rustycorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: command line parsing broken in 2.6.15-git?
Message-ID: <20060106113445.57ddaf7f@dxpl.pdx.osdl.net>
In-Reply-To: <5a4c581d0601051720w73132c89j218864dd4e313427@mail.gmail.com>
References: <20060105163922.7806343b@dxpl.pdx.osdl.net>
	<5a4c581d0601051720w73132c89j218864dd4e313427@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006 02:20:34 +0100
Alessandro Suardi <alessandro.suardi@gmail.com> wrote:

> On 1/6/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> > The command line parsing or psmouse driver is broken now, this
> > makes my mouse go wacky on a KVM. It worked up until the latest
> > git updates (post 2.6.15)
> >
> > Dmesg output:
> >
> > Kernel command line: root=/dev/md2 vga=0x31a ro selinux=0 psmouse.proto=bare
> > Unknown boot option `psmouse.proto=bare': ignoring
> 
> Similar issue here... my DVD drive disappeared in 2.6.15-git1 because
>

Look at /sys/module directory. All the modules that gets compiled in is now being
quoted. Looks like some macro screw up!

# ls /sys/module
"8250"   ext3            iptable_nat  jbd        "psmouse"           skge
ac       fan             ip_tables    lockd      raid0               sunrpc
aic7xxx  "i8042"         ipt_limit    "md_mod"   raid1               "tcp_bic"
battery  "ide_cd"        ipt_LOG      mii        reiserfs            thermal
button   ip_conntrack    ipt_pkttype  nfnetlink  scsi_mod
dm_mod   ip_nat          ipt_REJECT   nfs        scsi_transport_spi
"drm"    iptable_filter  ipt_state    nfs_acl    sd_mod
e100     iptable_mangle  ipv6         processor
