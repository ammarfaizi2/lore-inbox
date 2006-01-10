Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWAJO12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWAJO12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWAJO12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:27:28 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:9123 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1751005AbWAJO11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:27:27 -0500
Date: Tue, 10 Jan 2006 15:27:25 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Andrew Morton <akpm@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.15] running tcpdump on 3c905b causes freeze (reproducable)
Message-ID: <20060110142725.GH12673@vanheusden.com>
References: <20060108114305.GA32425@vanheusden.com>
	<20060109041114.6e797a9b.akpm@osdl.org>
	<20060109144522.GB10955@vanheusden.com>
	<20060109193754.GD12673@vanheusden.com>
	<20060109224821.7a40bc69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109224821.7a40bc69.akpm@osdl.org>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Tue Jan 10 20:12:10 CET 2006
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Have you tried enabling the NMI watchdog?  Enable CONFIG_X86_LOCAL_APIC and
> > > > boot with `nmi_watchdog=1' on the command line, make sure that the NMI line
> > > > of /proc/interrupts is incrementing.
> > > I'll give it a try. I've added it to the append-line in the lilo config.
> > > Am now compiling the kernel.
> > No change. Well, that is: the last message on the console now is
> > "setting eth1 to promiscues mode".
> Did you confirm that the NMI counters in /proc/interrupts are incrementing?

Yes:
root@muur:/home/folkert# for i in `seq 1 5` ; do cat /proc/interrupts  | grep NMI ; sleep 1 ; done
NMI:    6949080    6949067
NMI:    6949182    6949169
NMI:    6949284    6949271
NMI:    6949386    6949373
NMI:    6949488    6949475


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
