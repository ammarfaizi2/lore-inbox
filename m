Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932377AbWFEBhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWFEBhn (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWFEBhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:37:43 -0400
Received: from CPE-147-10-67-142.vic.bigpond.net.au ([147.10.67.142]:57756
	"HELO fester.wow.nailed.org") by vger.kernel.org with SMTP
	id S932377AbWFEBhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:37:42 -0400
Date: Mon, 5 Jun 2006 11:58:55 +1000
From: Mick <mick@wow.nailed.org>
To: linux-kernel@vger.kernel.org
Subject: PPPOA - Badness in local_bh_enable at kernel/softirq.c:140
Message-ID: <20060605115855.2b9f573e@morticia.wow.nailed.org>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I hope this is the correct place to post this.
I am having problems creating a PPPOA connection.
The machine is a dual AMD Opteron 275 running Gentoo compiled for amd64 with kernel 2.6.15-gentoo-r1.

I am trying to connect using a Foresystem HE 155 OC3 card.
I seem to only get the error when I receive a reply from the remote server.
Below I have tried to include the relevent lines from /var/log/messages.
I get lots of the "Badness in local_bh_enable at kernel/softirq.c:140" messages
until the server finally stops responding.
This is very repeatable. 
The machine doesn't crash straight away, but it will stop responding after a few minuits.

I have sucessfully pushed other traffic through the OC3 card. PPPOE using the br2684 kernel module has also worked.
So far I only get this problem when I try connecting with PPPOA.

Any help would be appreciated.
Thank you


Jun  1 18:35:44 thunderbird1 pppd[11820]: Plugin /usr/lib/pppd/2.4.3/pppoatm.so loaded.
Jun  1 18:35:44 thunderbird1 pppd[11820]: PPPoATM plugin_init
Jun  1 18:35:44 thunderbird1 pppd[11820]: PPPoATM setdevname_pppoatm - SUCCESS:0.0.35
Jun  1 18:35:44 thunderbird1 pppd[11820]: pppd 2.4.3 started by root, uid 0
Jun  1 18:35:44 thunderbird1 pppd[11820]: using channel 35
Jun  1 18:35:44 thunderbird1 pppd[11820]: Using interface ppp0
Jun  1 18:35:44 thunderbird1 pppd[11820]: Connect: ppp0 <--> 0.0.35
Jun  1 18:35:44 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x1 <magic 0xca19f1e6>]
Jun  1 18:35:47 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x1 <magic 0xca19f1e6>]
Jun  1 18:35:50 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x1 <magic 0xca19f1e6>]
Jun  1 18:35:53 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x1 <magic 0xca19f1e6>]
Jun  1 18:35:56 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x1 <magic 0xca19f1e6>]
Jun  1 18:35:59 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x1 <magic 0xca19f1e6>]
Jun  1 18:36:02 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x1 <magic 0xca19f1e6>]
Jun  1 18:36:05 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x1 <magic 0xca19f1e6>]
Jun  1 18:36:08 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x1 <magic 0xca19f1e6>]
Jun  1 18:36:11 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x1 <magic 0xca19f1e6>]
Jun  1 18:36:14 thunderbird1 pppd[11820]: LCP: timeout sending Config-Requests
Jun  1 18:36:14 thunderbird1 pppd[11820]: Connection terminated.
Jun  1 18:36:14 thunderbird1 pppd[11820]: Modem hangup
Jun  1 18:36:44 thunderbird1 pppd[11820]: using channel 36
Jun  1 18:36:44 thunderbird1 pppd[11820]: Using interface ppp0
Jun  1 18:36:44 thunderbird1 pppd[11820]: Connect: ppp0 <--> 0.0.35
Jun  1 18:36:44 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x2 <magic 0x185ebf16>]
Jun  1 18:36:47 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x2 <magic 0x185ebf16>]
Jun  1 18:36:50 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x2 <magic 0x185ebf16>]
Jun  1 18:36:53 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x2 <magic 0x185ebf16>]
Jun  1 18:36:56 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x2 <magic 0x185ebf16>]
Jun  1 18:36:59 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x2 <magic 0x185ebf16>]
Jun  1 18:37:02 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x2 <magic 0x185ebf16>]
Jun  1 18:37:05 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x2 <magic 0x185ebf16>]
Jun  1 18:37:08 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x2 <magic 0x185ebf16>]
Jun  1 18:37:11 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x2 <magic 0x185ebf16>]
Jun  1 18:37:14 thunderbird1 pppd[11820]: LCP: timeout sending Config-Requests
Jun  1 18:37:14 thunderbird1 pppd[11820]: Connection terminated.
Jun  1 18:37:14 thunderbird1 pppd[11820]: Modem hangup
Jun  1 18:37:44 thunderbird1 pppd[11820]: using channel 37
Jun  1 18:37:44 thunderbird1 pppd[11820]: Using interface ppp0
Jun  1 18:37:44 thunderbird1 pppd[11820]: Connect: ppp0 <--> 0.0.35
Jun  1 18:37:44 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x3 <magic 0xb3ad788f>]
Jun  1 18:37:47 thunderbird1 pppd[11820]: sent [LCP ConfReq id=0x3 <magic 0xb3ad788f>]
Jun  1 18:37:50 thunderbird1 pppd[11820]: Terminating on signal 2
Jun  1 18:37:50 thunderbird1 pppd[11820]: sent [LCP TermReq id=0x4 "User request"]
Jun  1 18:37:53 thunderbird1 pppd[11820]: sent [LCP TermReq id=0x5 "User request"]
Jun  1 18:37:56 thunderbird1 pppd[11820]: Connection terminated.
Jun  1 18:37:56 thunderbird1 pppd[11820]: Modem hangup
Jun  1 18:37:56 thunderbird1 pppd[11820]: Exit.
Jun  1 18:38:33 thunderbird1 pppd[11892]: Plugin /usr/lib/pppd/2.4.3/pppoatm.so loaded.
Jun  1 18:38:33 thunderbird1 pppd[11892]: PPPoATM plugin_init
Jun  1 18:38:33 thunderbird1 pppd[11892]: PPPoATM setdevname_pppoatm - SUCCESS:0.0.35
Jun  1 18:38:33 thunderbird1 pppd[11892]: pppd 2.4.3 started by root, uid 0
Jun  1 18:38:33 thunderbird1 pppd[11892]: using channel 38
Jun  1 18:38:33 thunderbird1 pppd[11892]: Using interface ppp0
Jun  1 18:38:33 thunderbird1 pppd[11892]: Connect: ppp0 <--> 0.0.35
Jun  1 18:38:33 thunderbird1 pppd[11892]: sent [LCP ConfReq id=0x1 <magic 0xcd78b75d>]
Jun  1 18:38:34 thunderbird1 pppd[11905]: pppd 2.4.2 started by root, uid 0
Jun  1 18:38:34 thunderbird1 pppd[11905]: Couldn't open pty slave /dev/pts/4: No such file or directory
Jun  1 18:38:34 thunderbird1 pppd[11905]: Using interface ppp1
Jun  1 18:38:34 thunderbird1 pppd[11905]: Connect: ppp1 <--> /dev/ttyp0
Jun  1 18:38:34 thunderbird1 Badness in local_bh_enable at kernel/softirq.c:140
Jun  1 18:38:34 thunderbird1 
Jun  1 18:38:34 thunderbird1 Call Trace: <IRQ> <ffffffff8013cebb>{local_bh_enable+50} <ffffffff8804506f>{:he:he_service_rbrq+1050}
Jun  1 18:38:34 thunderbird1 <ffffffff88045585>{:he:he_tasklet+163} <ffffffff8013d164>{tasklet_action+101}
Jun  1 18:38:34 thunderbird1 <ffffffff8013ce10>{__do_softirq+80} <ffffffff80110c5b>{call_softirq+31}
Jun  1 18:38:34 thunderbird1 <ffffffff80112248>{do_softirq+47} <ffffffff80112114>{do_IRQ+50}
Jun  1 18:38:34 thunderbird1 <ffffffff8010fe7c>{ret_from_intr+0}  <EOI> <ffffffff8010dc09>{default_idle+0}
Jun  1 18:38:34 thunderbird1 <ffffffff8010dc3e>{default_idle+53} <ffffffff8010de74>{cpu_idle+143}
Jun  1 18:38:34 thunderbird1 <ffffffff805f079a>{start_kernel+439} <ffffffff805f0276>{_sinittext+630}
Jun  1 18:38:34 thunderbird1 
Jun  1 18:38:34 thunderbird1 Badness in local_bh_enable at kernel/softirq.c:140
Jun  1 18:38:34 thunderbird1 
Jun  1 18:38:34 thunderbird1 Call Trace: <IRQ> <ffffffff8013cebb>{local_bh_enable+50} <ffffffff8804506f>{:he:he_service_rbrq+1050}
Jun  1 18:38:34 thunderbird1 <ffffffff88045585>{:he:he_tasklet+163} <ffffffff8013d164>{tasklet_action+101}
Jun  1 18:38:34 thunderbird1 <ffffffff8013ce10>{__do_softirq+80} <ffffffff80110c5b>{call_softirq+31}
Jun  1 18:38:34 thunderbird1 <ffffffff80112248>{do_softirq+47} <ffffffff80112114>{do_IRQ+50}
Jun  1 18:38:34 thunderbird1 <ffffffff8010fe7c>{ret_from_intr+0}  <EOI> <ffffffff8010dc09>{default_idle+0}
Jun  1 18:38:34 thunderbird1 <ffffffff8010dc3e>{default_idle+53} <ffffffff8010de74>{cpu_idle+143}
Jun  1 18:38:34 thunderbird1 <ffffffff805f079a>{start_kernel+439} <ffffffff805f0276>{_sinittext+630}
Jun  1 18:38:34 thunderbird1 
Jun  1 18:38:34 thunderbird1 pppd[11892]: rcvd [LCP ConfReq id=0x1 <magic 0x8b28d6af>] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Jun  1 18:38:34 thunderbird1 pppd[11892]: sent [LCP ConfAck id=0x1 <magic 0x8b28d6af>]
Jun  1 18:38:34 thunderbird1 pppd[11892]: rcvd [LCP ConfAck id=0x1 <magic 0xcd78b75d>] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Jun  1 18:38:34 thunderbird1 pppd[11892]: sent [LCP EchoReq id=0x0 magic=0xcd78b75d]
Jun  1 18:38:34 thunderbird1 pppd[11892]: sent [IPCP ConfReq id=0x1 <addr 0.0.0.0>]
Jun  1 18:38:34 thunderbird1 Badness in local_bh_enable at kernel/softirq.c:140
Jun  1 18:38:34 thunderbird1 
Jun  1 18:38:34 thunderbird1 Call Trace: <IRQ> <ffffffff8013cebb>{local_bh_enable+50} <ffffffff8804506f>{:he:he_service_rbrq+1050}
Jun  1 18:38:34 thunderbird1 <ffffffff88045585>{:he:he_tasklet+163} <ffffffff8013d164>{tasklet_action+101}
Jun  1 18:38:34 thunderbird1 <ffffffff8013ce10>{__do_softirq+80} <ffffffff80110c5b>{call_softirq+31}
Jun  1 18:38:34 thunderbird1 <ffffffff80112248>{do_softirq+47} <ffffffff80112114>{do_IRQ+50}
Jun  1 18:38:34 thunderbird1 <ffffffff8010fe7c>{ret_from_intr+0}  <EOI> <ffffffff8010dc09>{default_idle+0}
Jun  1 18:38:34 thunderbird1 <ffffffff8010dc3e>{default_idle+53} <ffffffff8010de74>{cpu_idle+143}
Jun  1 18:38:34 thunderbird1 <ffffffff805f079a>{start_kernel+439} <ffffffff805f0276>{_sinittext+630}
Jun  1 18:38:34 thunderbird1 
Jun  1 18:38:34 thunderbird1 Badness in local_bh_enable at kernel/softirq.c:140
Jun  1 18:38:34 thunderbird1 
Jun  1 18:38:34 thunderbird1 Call Trace: <IRQ> <ffffffff8013cebb>{local_bh_enable+50} <ffffffff88017caf>{:ppp_generic:ppp_input+329}
Jun  1 18:38:34 thunderbird1 <ffffffff8804506f>{:he:he_service_rbrq+1050} <ffffffff88045585>{:he:he_tasklet+163}
Jun  1 18:38:34 thunderbird1 <ffffffff8013d164>{tasklet_action+101} <ffffffff8013ce10>{__do_softirq+80}
Jun  1 18:38:34 thunderbird1 <ffffffff80110c5b>{call_softirq+31} <ffffffff80112248>{do_softirq+47}
Jun  1 18:38:34 thunderbird1 <ffffffff80112114>{do_IRQ+50} <ffffffff8010fe7c>{ret_from_intr+0}
Jun  1 18:38:34 thunderbird1 <EOI> <ffffffff8010dc09>{default_idle+0} <ffffffff8010dc3e>{default_idle+53}
Jun  1 18:38:34 thunderbird1 <ffffffff8010de74>{cpu_idle+143} <ffffffff805f079a>{start_kernel+439}
Jun  1 18:38:34 thunderbird1 <ffffffff805f0276>{_sinittext+630} 
Jun  1 18:38:34 thunderbird1 Badness in local_bh_enable at kernel/softirq.c:140
Jun  1 18:38:34 thunderbird1 
Jun  1 18:38:34 thunderbird1 Call Trace: <IRQ> <ffffffff8013cebb>{local_bh_enable+50} <ffffffff8804506f>{:he:he_service_rbrq+1050}
Jun  1 18:38:34 thunderbird1 <ffffffff88045585>{:he:he_tasklet+163} <ffffffff8013d164>{tasklet_action+101}
Jun  1 18:38:34 thunderbird1 <ffffffff8013ce10>{__do_softirq+80} <ffffffff80110c5b>{call_softirq+31}
Jun  1 18:38:34 thunderbird1 <ffffffff80112248>{do_softirq+47} <ffffffff80112114>{do_IRQ+50}
Jun  1 18:38:34 thunderbird1 <ffffffff8010fe7c>{ret_from_intr+0}  <EOI> <ffffffff8010dc09>{default_idle+0}
Jun  1 18:38:34 thunderbird1 <ffffffff8010dc3e>{default_idle+53} <ffffffff8010de74>{cpu_idle+143}
Jun  1 18:38:34 thunderbird1 <ffffffff805f079a>{start_kernel+439} <ffffffff805f0276>{_sinittext+630}
.
.
.
.
.
.
Jun  1 19:14:54 thunderbird1 Badness in local_bh_enable at kernel/softirq.c:140
Jun  1 19:14:54 thunderbird1 
Jun  1 19:14:54 thunderbird1 Call Trace: <IRQ> <ffffffff8013cebb>{local_bh_enable+50} <ffffffff8804506f>{:he:he_service_rbr
q+1050}
Jun  1 19:14:54 thunderbird1 <ffffffff88045585>{:he:he_tasklet+163} <ffffffff8013d164>{tasklet_action+101}
Jun  1 19:14:54 thunderbird1 <ffffffff8013ce10>{__do_softirq+80} <ffffffff80110c5b>{call_softirq+31}
Jun  1 19:14:54 thunderbird1 <ffffffff80112248>{do_softirq+47} <ffffffff80112114>{do_IRQ+50}
Jun  1 19:14:54 thunderbird1 <ffffffff8010fe7c>{ret_from_intr+0}  <EOI> <ffffffff8010dc09>{default_idle+0}
Jun  1 19:14:54 thunderbird1 <ffffffff8010dc3e>{default_idle+53} <ffffffff8010de74>{cpu_idle+143}
Jun  1 19:14:54 thunderbird1 <ffffffff805f079a>{start_kernel+439} <ffffffff805f0276>{_sinittext+630}
Jun  1 19:14:54 thunderbird1 
Jun  1 19:14:55 thunderbird1 Badness in local_bh_enable at kernel/softirq.c:140
Jun  1 19:14:55 thunderbird1 
Jun  1 19:14:55 thunderbird1 Call Trace: <IRQ> <ffffffff8013cebb>{local_bh_enable+50} <ffffffff8804506f>{:he:he_service_rbr
q+1050}
Jun  1 19:14:55 thunderbird1 <ffffffff88045585>{:he:he_tasklet+163} <ffffffff8013d164>{tasklet_action+101}
Jun  1 19:14:55 thunderbird1 <ffffffff8013ce10>{__do_softirq+80} <ffffffff80110c5b>{call_softirq+31}
Jun  1 19:14:55 thunderbird1 <ffffffff80112248>{do_softirq+47} <ffffffff80112114>{do_IRQ+50}
Jun  1 19:14:55 thunderbird1 <ffffffff8010fe7c>{ret_from_intr+0}  <EOI> <ffffffff8010f8da>{system_call+126}
Jun  1 19:14:55 thunderbird1 

Machine stoped responding here.
