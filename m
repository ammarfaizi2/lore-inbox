Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVBWVrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVBWVrP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVBWVrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:47:14 -0500
Received: from kunet.com ([69.26.169.26]:34059 "EHLO kunet.com")
	by vger.kernel.org with ESMTP id S261617AbVBWVpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:45:54 -0500
Message-ID: <003001c519f1$031afc00$7101a8c0@shrugy>
From: "Ammar T. Al-Sayegh" <ammar@kunet.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
References: <009d01c519e8$166768b0$7101a8c0@shrugy> <1109192040.6290.108.camel@laptopd505.fenrus.org>
Subject: Re: kernel BUG at mm/rmap.c:483!
Date: Wed, 23 Feb 2005 16:45:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2005-02-23 at 15:41 -0500, Ammar T. Al-Sayegh wrote:
>> Hi All,
>> 
>> I recently installed Fedora RC3 on a new server.
>> The kernel is 2.6.10-1.741_FC3smp. The server
>> crashes every few days. When I examine /var/log/messages,
>> I find the following line just before the crash:
>> 
>> Feb 22 23:50:35 hostname kernel: ------------[ cut here ]------------
>> Feb 22 23:50:35 hostname kernel: kernel BUG at mm/rmap.c:483!
>> 
>> No further debug lines are given to diagnose the
>> source of the 
> no oops at all?

No. Is there a way to enable the kernel to give more
diagnostic debug output next time this error happens?

Is there a way to at least make the server reboot itself
next time the kernel is alerted to this problem before
crashing? When the server is rebooted, it works fine for
few more days before encountering this problem and
crashing again.

 
> which modules are you using?

[root ~]# lsmod 
Module                  Size  Used by
ip_conntrack_ftp       76145  0 
md5                     8001  1 
ipv6                  236769  78 
autofs4                21829  0 
i2c_dev                13249  0 
i2c_core               24513  1 i2c_dev
sunrpc                135077  1 
ipt_REJECT             10561  2 
ipt_state               5825  79 
ip_conntrack           45317  2 ip_conntrack_ftp,ipt_state
iptable_filter          7489  1 
ip_tables              20929  3 ipt_REJECT,ipt_state,iptable_filter
microcode              11489  0 
dm_mod                 57925  0 
video                  19653  0 
button                 10577  0 
battery                13253  0 
ac                      8773  0 
uhci_hcd               33497  0 
ehci_hcd               33737  0 
e1000                  84629  0 
floppy                 56913  0 
ext3                  117961  6 
jbd                    57177  1 ext3
3w_xxxx                30561  0 
ata_piix               12485  7 
libata                 44101  1 ata_piix
sd_mod                 20545  9 
scsi_mod              116033  3 3w_xxxx,libata,sd_mod

Any clue?


-ammar
