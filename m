Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWGBLqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWGBLqU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 07:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWGBLqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 07:46:20 -0400
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:43784 "EHLO
	smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP
	id S964883AbWGBLqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 07:46:19 -0400
Message-ID: <44A7B207.4040901@xs4all.nl>
Date: Sun, 02 Jul 2006 13:46:15 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Oops / BUG? (2.6.17.2 on VIA Epia CL6000)
References: <44A7AADB.8040106@xs4all.nl>	 <1151839268.3111.10.camel@laptopd505.fenrus.org>	 <44A7ACF2.4070304@xs4all.nl> <1151840308.3111.14.camel@laptopd505.fenrus.org>
In-Reply-To: <1151840308.3111.14.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2006-07-02 at 13:24 +0200, Udo van den Heuvel wrote:
>
>> CONFIG_KALLSYMS=y
> 
> hmmmmm then something really bad happened, so bad that even the
> backtrace is corrupted ;(
> 
> I'm sorry to say but unless you already have a suspect, those are really
> really hard to diagnose or fix. One thing you can do is remove all
> modules you don't actually use (just from a statistical pov that reduces
> the risk of it repeating)... and hope maybe a next backtrace does
> provide more information.

Later another one happened with less info. Maybe the `different`
location helps?

Jul  2 09:07:30 epia kernel: BUG: unable to handle kernel paging request
at virtual address fec9bd89
Jul  2 09:07:30 epia kernel:  printing eip:
Jul  2 09:07:30 epia kernel: fec9bd89
Jul  2 09:07:30 epia kernel: *pde = 00000000
Jul  2 09:07:30 epia kernel: Oops: 0000 [#1]
Jul  2 09:07:30 epia kernel: PREEMPT
Jul  2 09:07:36 epia kernel: Modules linked in: sch_tbf xt_string
xt_MARK xt_length xt_tcpmss xt_mac xt_mark vt1211 hwmon_vid i2c_isa
ipt_ttl ipt_owner ip_nat_irc ip_conntrack_irc ipt_REDIRECT ipt_tos
ip_nat_ftp ip_conntrack_ftp ip_nat_h323 ip_conntrack_h323 ipt_MASQUERADE
ipt_LOG ipt_TCPMSS ipt_REJECT xt_limit xt_state ipt_TARPIT
iptable_filter ipt_TOS iptable_mangle xt_NOTRACK iptable_raw binfmt_misc
lp parport_pc parport nvram ehci_hcd snd_via82xx snd_ac97_codec
snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
uhci_hcd snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc
snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro
Jul  2 09:07:42 epia kernel: CPU:    0
Jul  2 09:07:42 epia kernel: EIP:    0060:[pg0+1049402761/1069728768]
 Not tainted VLI
Jul  2 09:07:42 epia kernel: EIP:    0060:[<fec9bd89>]    Not tainted VLI
Jul  2 09:07:42 epia kernel: EFLAGS: 00010296   (2.6.17.2 #3)
Jul  2 09:07:42 epia kernel: EIP is at 0xfec9bd89


Kind regards,
Udo
