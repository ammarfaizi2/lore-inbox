Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946848AbWKJXyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946848AbWKJXyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 18:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946852AbWKJXyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 18:54:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:31423 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946848AbWKJXyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 18:54:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=nXs6T9hcGIBtX0V/02XzLPc7qEkzyaRflz40RWp0T+l/n2+hpdOg7k5kadgtj9jXdVRI3L+/rM32N3Dp4+NiCkCE61/RQ6K959qjYuV35eA7dmwUIDB6YTKi3NDsc+AmRoahWanGFXePSQ/9iLCY9l/eKj21xBpMLn5Ti0ooaFE=
Message-ID: <45551135.7000201@gmail.com>
Date: Sat, 11 Nov 2006 00:54:29 +0100
From: Trifon Trifonov <triffon@gmail.com>
User-Agent: Mozilla Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mmc0 power consumption
Content-Type: multipart/mixed;
 boundary="------------030602090002090703060808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030602090002090703060808
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
  I would like to report an issue with my O2Micro 4-in-1 Card reader. I 
am using kernel 2.6.17-10. Actually, the device works properly (although 
it wasn't like that with 2.6.15). I am just troubled by getting messages 
in the syslog about the mmc0 device consuming too much power after 
issuing ACPI suspend to RAM. I also don't have obvious problems with 
suspending, except that after the first suspend it will no longer 
suspend by closing the lid, so I have to do this manually. Also, after 
the first suspend, statistics show that battery consumption of my laptop 
seems to rise. So I suspect that something isn't right with the suspend.
  I reported this issue to <sdhci-devel -at- list.drzeus.cx>, as 
suggested by the log, but they supposed that this is a PCI issue and 
redirected me to this mailing list.
  I am attaching three files:
mmclog1.txt - syslog after ACPI suspend to RAM
mmclog2.txt - syslog after plugging in an SD card
lspci.txt - lspci -vv output
  I hope this report is helpful for somebody.

Best regards,
  Trifon Trifonov

--------------030602090002090703060808
Content-Type: text/plain;
 name="mmclog1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmclog1.txt"

Nov  7 23:48:08 localhost kernel: [17183839.520000] Stopping tasks: ================================================================================================================================================|
Nov  7 23:48:08 localhost kernel: [17183842.340000] ACPI: PCI interrupt for device 0000:06:07.2 disabled
Nov  7 23:48:08 localhost kernel: [17183842.348000] mmc0: Got command interrupt even though no command operation was in progress.
Nov  7 23:48:08 localhost kernel: [17183842.348000] mmc0: Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183842.348000] mmc0: Card is consuming too much power!
Nov  7 23:48:08 localhost kernel: [17183842.348000] mmc0: Unexpected interrupt 0x00800000. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183842.348000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183842.964000] ACPI: PCI interrupt for device 0000:01:00.0 disabled
Nov  7 23:48:08 localhost kernel: [17183842.964000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
Nov  7 23:48:08 localhost kernel: [17183842.964000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
Nov  7 23:48:08 localhost kernel: [17183842.980000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
Nov  7 23:48:08 localhost kernel: [17183842.980000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
Nov  7 23:48:08 localhost kernel: [17183842.980000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
Nov  7 23:48:08 localhost kernel: [17183842.980000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Nov  7 23:48:08 localhost kernel: [17183842.992000] mmc0: Controller never released inhibit bit(s). Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183842.992000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183842.992000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.992000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.992000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.992000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183842.992000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183842.992000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.992000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183842.992000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183842.992000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183842.992000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183842.992000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183843.004000] mmc0: Reset 0x2 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183843.004000] mmc0: Reset 0x4 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183843.004000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183843.204000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
Nov  7 23:48:08 localhost kernel: [17183843.204000] Back to C!
Nov  7 23:48:08 localhost kernel: [17183867.204000] PM: Writing back config space on device 0000:00:01.0 at offset f (was a0100, writing a010a)
Nov  7 23:48:08 localhost kernel: [17183867.204000] PM: Writing back config space on device 0000:00:01.0 at offset a (was f, writing 0)
Nov  7 23:48:08 localhost kernel: [17183867.204000] PM: Writing back config space on device 0000:00:01.0 at offset 8 (was ff30, writing ff30ff30)
Nov  7 23:48:08 localhost kernel: [17183867.204000] PM: Writing back config space on device 0000:00:01.0 at offset 1 (was 100107, writing 100507)
Nov  7 23:48:08 localhost kernel: [17183867.204000] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Nov  7 23:48:08 localhost kernel: [17183867.204000] PCI: Setting latency timer of device 0000:00:01.0 to 64
Nov  7 23:48:08 localhost kernel: [17183867.204000] PM: Writing back config space on device 0000:00:1b.0 at offset 3 (was 0, writing 8)
Nov  7 23:48:08 localhost kernel: [17183867.204000] PM: Writing back config space on device 0000:00:1b.0 at offset 1 (was 100006, writing 100002)
Nov  7 23:48:08 localhost kernel: [17183867.204000] ACPI: PCI Interrupt 0000:00:1b.0[D] -> GSI 22 (level, low) -> IRQ 58
Nov  7 23:48:08 localhost kernel: [17183867.204000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
Nov  7 23:48:08 localhost kernel: [17183867.216000] mmc0: Controller never released inhibit bit(s). Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183867.216000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183867.216000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.216000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.216000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.216000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.216000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.216000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.216000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.216000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.216000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.216000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.216000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183867.228000] mmc0: Reset 0x2 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183867.228000] mmc0: Reset 0x4 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.228000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183867.424000] mmc0: Controller never released inhibit bit(s). Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183867.424000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183867.424000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.424000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.424000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.424000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.424000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.424000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.424000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.424000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.424000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.424000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.424000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183867.436000] mmc0: Reset 0x2 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183867.436000] mmc0: Reset 0x4 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.436000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183867.636000] mmc0: Controller never released inhibit bit(s). Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183867.636000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183867.636000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.636000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.636000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.636000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.636000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.636000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.636000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.636000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.636000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.636000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.636000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183867.644000] mmc0: Reset 0x2 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183867.644000] mmc0: Reset 0x4 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.644000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183867.844000] mmc0: Controller never released inhibit bit(s). Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183867.844000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183867.844000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.844000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.844000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.844000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.844000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.844000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.844000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.844000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.844000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.844000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.844000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183867.852000] mmc0: Reset 0x2 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183867.852000] mmc0: Reset 0x4 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183867.852000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183868.052000] mmc0: Controller never released inhibit bit(s). Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183868.052000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183868.052000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.052000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.052000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.052000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183868.052000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183868.052000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.052000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.052000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.052000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.052000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.052000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183868.064000] mmc0: Reset 0x2 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183868.064000] mmc0: Reset 0x4 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.064000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183868.260000] mmc0: Reset 0x1 never completed. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183868.260000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183868.260000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.260000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.260000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.260000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183868.260000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183868.260000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.260000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.260000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.260000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.260000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.260000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.0 at offset f (was 20100, writing 2010a)
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.0 at offset 7 (was f0, writing 200000f0)
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.0 at offset 3 (was 810000, writing 810008)
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.0 at offset 1 (was 100104, writing 100504)
Nov  7 23:48:08 localhost kernel: [17183868.452000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
Nov  7 23:48:08 localhost kernel: [17183868.452000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.1 at offset f (was 20200, writing 2020b)
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.1 at offset 7 (was f0, writing 200000f0)
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.1 at offset 3 (was 810000, writing 810008)
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.1 at offset 1 (was 100106, writing 100506)
Nov  7 23:48:08 localhost kernel: [17183868.452000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
Nov  7 23:48:08 localhost kernel: [17183868.452000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.2 at offset f (was 20300, writing 20305)
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.2 at offset 9 (was c7d1c7d1, writing 1fff1)
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.2 at offset 8 (was c7c0bfc0, writing fff0)
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.2 at offset 3 (was 810000, writing 810008)
Nov  7 23:48:08 localhost kernel: [17183868.452000] PM: Writing back config space on device 0000:00:1c.2 at offset 1 (was 100104, writing 100505)
Nov  7 23:48:08 localhost kernel: [17183868.452000] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
Nov  7 23:48:08 localhost kernel: [17183868.452000] PCI: Setting latency timer of device 0000:00:1c.2 to 64
Nov  7 23:48:08 localhost kernel: [17183868.452000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 50
Nov  7 23:48:08 localhost kernel: [17183868.452000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
Nov  7 23:48:08 localhost kernel: [17183868.452000] usb usb1: root hub lost power or was reset
Nov  7 23:48:08 localhost kernel: [17183868.452000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 58
Nov  7 23:48:08 localhost kernel: [17183868.452000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
Nov  7 23:48:08 localhost kernel: [17183868.452000] usb usb2: root hub lost power or was reset
Nov  7 23:48:08 localhost kernel: [17183868.452000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 21 (level, low) -> IRQ 66
Nov  7 23:48:08 localhost kernel: [17183868.452000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
Nov  7 23:48:08 localhost kernel: [17183868.452000] usb usb3: root hub lost power or was reset
Nov  7 23:48:08 localhost kernel: [17183868.452000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 20 (level, low) -> IRQ 74
Nov  7 23:48:08 localhost kernel: [17183868.452000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
Nov  7 23:48:08 localhost kernel: [17183868.452000] usb usb4: root hub lost power or was reset
Nov  7 23:48:08 localhost kernel: [17183868.468000] ACPI: PCI Interrupt 0000:00:1d.7[C] -> GSI 21 (level, low) -> IRQ 66
Nov  7 23:48:08 localhost kernel: [17183868.468000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
Nov  7 23:48:08 localhost kernel: [17183868.468000] PM: Writing back config space on device 0000:00:1e.0 at offset f (was 20000, writing 200ff)
Nov  7 23:48:08 localhost kernel: [17183868.468000] PM: Writing back config space on device 0000:00:1e.0 at offset 7 (was a280d0d0, writing a28000f0)
Nov  7 23:48:08 localhost kernel: [17183868.468000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
Nov  7 23:48:08 localhost kernel: [17183868.468000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
Nov  7 23:48:08 localhost kernel: [17183868.468000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
Nov  7 23:48:08 localhost kernel: [17183868.468000] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
Nov  7 23:48:08 localhost kernel: [17183868.468000] PCI: Setting latency timer of device 0000:01:00.0 to 64
Nov  7 23:48:08 localhost kernel: [17183868.496000] PM: Writing back config space on device 0000:03:00.0 at offset 3 (was 0, writing 8)
Nov  7 23:48:08 localhost kernel: [17183868.496000] PM: Writing back config space on device 0000:03:00.0 at offset 1 (was 100000, writing 100002)
Nov  7 23:48:08 localhost kernel: [17183868.496000] PM: Writing back config space on device 0000:06:03.0 at offset f (was 18030100, writing 18030105)
Nov  7 23:48:08 localhost kernel: [17183868.496000] PM: Writing back config space on device 0000:06:03.0 at offset 4 (was 0, writing ffdfe000)
Nov  7 23:48:08 localhost kernel: [17183868.496000] PM: Writing back config space on device 0000:06:03.0 at offset 3 (was 0, writing 4008)
Nov  7 23:48:08 localhost kernel: [17183868.496000] PM: Writing back config space on device 0000:06:03.0 at offset 1 (was 2900000, writing 2900002)
Nov  7 23:48:08 localhost kernel: [17183868.496000] PM: Writing back config space on device 0000:06:07.0 at offset f (was 100, writing 10a)
Nov  7 23:48:08 localhost kernel: [17183868.496000] PM: Writing back config space on device 0000:06:07.0 at offset 5 (was 0, writing ffdfc800)
Nov  7 23:48:08 localhost kernel: [17183868.496000] PM: Writing back config space on device 0000:06:07.0 at offset 4 (was 0, writing ff500000)
Nov  7 23:48:08 localhost kernel: [17183868.496000] PM: Writing back config space on device 0000:06:07.0 at offset 3 (was 800000, writing 804008)
Nov  7 23:48:08 localhost kernel: [17183868.496000] PM: Writing back config space on device 0000:06:07.0 at offset 1 (was 2100087, writing 2180017)
Nov  7 23:48:08 localhost kernel: [17183868.496000] ACPI: PCI Interrupt 0000:06:07.0[A] -> GSI 16 (level, low) -> IRQ 169
Nov  7 23:48:08 localhost kernel: [17183868.512000] mmc0: Got command interrupt even though no command operation was in progress.
Nov  7 23:48:08 localhost kernel: [17183868.512000] mmc0: Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: ===========================================
Nov  7 23:48:08 localhost kernel: [17183868.512000] mmc0: Card is consuming too much power!
Nov  7 23:48:08 localhost kernel: [17183868.512000] mmc0: Unexpected interrupt 0x00800000. Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: Caps:     0xffffffff | Max curr: 0xffffffff
Nov  7 23:48:08 localhost kernel: [17183868.512000] sdhci: ===========================================

--------------030602090002090703060808
Content-Type: text/plain;
 name="mmclog2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmclog2.txt"

Nov  7 23:54:33 localhost kernel: [17184254.076000] mmcblk0: error 1 transferring data
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 102
Nov  7 23:54:33 localhost kernel: [17184254.076000] Buffer I/O error on device mmcblk0p1, logical block 1
Nov  7 23:54:33 localhost kernel: [17184254.076000] lost page write due to I/O error on mmcblk0p1
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmc0: Got data interrupt even though no data operation was in progress.
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmc0: Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Sys addr: 0x00000000 | Version:  0x00001010
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Blk size: 0x00007200 | Blk cnt:  0x00000001
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Argument: 0x00014600 | Trn mode: 0x00000002
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Present:  0x01ff0506 | Host ctl: 0x00000003
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Timeout:  0x00000009 | Int stat: 0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Int enab: 0x00ff00fb | Sig enab: 0x00ff00fb
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Caps:     0x038021a1 | Max curr: 0x00ffffff
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: ===========================================
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmcblk0: error 1 sending read/write command
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 163
Nov  7 23:54:33 localhost kernel: [17184254.076000] Buffer I/O error on device mmcblk0p1, logical block 62
Nov  7 23:54:33 localhost kernel: [17184254.076000] lost page write due to I/O error on mmcblk0p1
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmc0: Got data interrupt even though no data operation was in progress.
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmc0: Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Sys addr: 0x00000000 | Version:  0x00001010
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Blk size: 0x00007200 | Blk cnt:  0x00000001
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Argument: 0x0001c000 | Trn mode: 0x00000002
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Present:  0x01ff0506 | Host ctl: 0x00000003
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Timeout:  0x00000009 | Int stat: 0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Int enab: 0x00ff00fb | Sig enab: 0x00ff00fb
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Caps:     0x038021a1 | Max curr: 0x00ffffff
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: ===========================================
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmcblk0: error 1 sending read/write command
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 224
Nov  7 23:54:33 localhost kernel: [17184254.076000] Buffer I/O error on device mmcblk0p1, logical block 123
Nov  7 23:54:33 localhost kernel: [17184254.076000] lost page write due to I/O error on mmcblk0p1
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmc0: Got data interrupt even though no data operation was in progress.
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmc0: Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Sys addr: 0x00000000 | Version:  0x00001010
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Blk size: 0x00007200 | Blk cnt:  0x00000001
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Argument: 0x00020000 | Trn mode: 0x00000002
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Present:  0x01ef0506 | Host ctl: 0x00000003
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Timeout:  0x00000009 | Int stat: 0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Int enab: 0x00ff00fb | Sig enab: 0x00ff00fb
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Caps:     0x038021a1 | Max curr: 0x00ffffff
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: ===========================================
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmcblk0: error 1 sending read/write command
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 256
Nov  7 23:54:33 localhost kernel: [17184254.076000] Buffer I/O error on device mmcblk0p1, logical block 155
Nov  7 23:54:33 localhost kernel: [17184254.076000] lost page write due to I/O error on mmcblk0p1
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmc0: Got data interrupt even though no data operation was in progress.
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmc0: Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Sys addr: 0x00000000 | Version:  0x00001010
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Blk size: 0x00007200 | Blk cnt:  0x00000001
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Argument: 0x00024000 | Trn mode: 0x00000002
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Present:  0x01ff0506 | Host ctl: 0x00000003
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Timeout:  0x00000009 | Int stat: 0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Int enab: 0x00ff00fb | Sig enab: 0x00ff00fb
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Caps:     0x038021a1 | Max curr: 0x00ffffff
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: ===========================================
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmcblk0: error 1 sending read/write command
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 288
Nov  7 23:54:33 localhost kernel: [17184254.076000] Buffer I/O error on device mmcblk0p1, logical block 187
Nov  7 23:54:33 localhost kernel: [17184254.076000] lost page write due to I/O error on mmcblk0p1
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmc0: Got data interrupt even though no data operation was in progress.
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmc0: Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Sys addr: 0x00000000 | Version:  0x00001010
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Blk size: 0x00007200 | Blk cnt:  0x00000001
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Argument: 0x00100000 | Trn mode: 0x00000002
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Present:  0x01ff0506 | Host ctl: 0x00000003
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Timeout:  0x00000009 | Int stat: 0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Int enab: 0x00ff00fb | Sig enab: 0x00ff00fb
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: Caps:     0x038021a1 | Max curr: 0x00ffffff
Nov  7 23:54:33 localhost kernel: [17184254.076000] sdhci: ===========================================
Nov  7 23:54:33 localhost kernel: [17184254.076000] mmcblk0: error 1 sending read/write command
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2048
Nov  7 23:54:33 localhost kernel: [17184254.076000] Buffer I/O error on device mmcblk0p1, logical block 1947
Nov  7 23:54:33 localhost kernel: [17184254.076000] lost page write due to I/O error on mmcblk0p1
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2049
Nov  7 23:54:33 localhost kernel: [17184254.076000] Buffer I/O error on device mmcblk0p1, logical block 1948
Nov  7 23:54:33 localhost kernel: [17184254.076000] lost page write due to I/O error on mmcblk0p1
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2050
Nov  7 23:54:33 localhost kernel: [17184254.076000] Buffer I/O error on device mmcblk0p1, logical block 1949
Nov  7 23:54:33 localhost kernel: [17184254.076000] lost page write due to I/O error on mmcblk0p1
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2051
Nov  7 23:54:33 localhost kernel: [17184254.076000] Buffer I/O error on device mmcblk0p1, logical block 1950
Nov  7 23:54:33 localhost kernel: [17184254.076000] lost page write due to I/O error on mmcblk0p1
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2052
Nov  7 23:54:33 localhost kernel: [17184254.076000] Buffer I/O error on device mmcblk0p1, logical block 1951
Nov  7 23:54:33 localhost kernel: [17184254.076000] lost page write due to I/O error on mmcblk0p1
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2053
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2054
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2055
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2056
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2057
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2058
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2059
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2060
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2061
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2062
Nov  7 23:54:33 localhost kernel: [17184254.076000] end_request: I/O error, dev mmcblk0, sector 2063
Nov  7 23:54:33 localhost kernel: [17184254.080000] mmc0: Got data interrupt even though no data operation was in progress.
Nov  7 23:54:33 localhost kernel: [17184254.080000] mmc0: Please report this to <sdhci-devel@list.drzeus.cx>.
Nov  7 23:54:33 localhost kernel: [17184254.080000] sdhci: ============== REGISTER DUMP ==============
Nov  7 23:54:33 localhost kernel: [17184254.080000] sdhci: Sys addr: 0x00000000 | Version:  0x00001010
Nov  7 23:54:33 localhost kernel: [17184254.080000] sdhci: Blk size: 0x00007200 | Blk cnt:  0x00000001
Nov  7 23:54:33 localhost kernel: [17184254.080000] sdhci: Argument: 0x00102000 | Trn mode: 0x00000002
Nov  7 23:54:33 localhost kernel: [17184254.080000] sdhci: Present:  0x01ff0506 | Host ctl: 0x00000003
Nov  7 23:54:33 localhost kernel: [17184254.080000] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.080000] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
Nov  7 23:54:33 localhost kernel: [17184254.080000] sdhci: Timeout:  0x00000009 | Int stat: 0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.080000] sdhci: Int enab: 0x00ff00fb | Sig enab: 0x00ff00fb
Nov  7 23:54:33 localhost kernel: [17184254.080000] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
Nov  7 23:54:33 localhost kernel: [17184254.080000] sdhci: Caps:     0x038021a1 | Max curr: 0x00ffffff
Nov  7 23:54:33 localhost kernel: [17184254.080000] sdhci: ===========================================
Nov  7 23:54:33 localhost kernel: [17184254.080000] mmcblk0: error 1 sending read/write command
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2064
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2065
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2066
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2067
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2068
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2069
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2070
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2071
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2072
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2073
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2074
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2075
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2076
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2077
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2078
Nov  7 23:54:33 localhost kernel: [17184254.080000] end_request: I/O error, dev mmcblk0, sector 2079

--------------030602090002090703060808
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express Memory Controller Hub (rev 03)
	Subsystem: Elitegroup Computer Systems Unknown device 0f69
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000cfff
	Memory behind bridge: ff300000-ff3fffff
	Prefetchable memory behind bridge: 00000000bdf00000-00000000dde00000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40c9
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
	Subsystem: Elitegroup Computer Systems Unknown device 0f69
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin D routed to IRQ 66
	Region 0: Memory at ffefc000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express Unknown type IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled CommClk- ExtSynch-
		Link: Speed unknown, Width x0

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40d1
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Memory behind bridge: ff400000-ff4fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40d9
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 0, PowerLimit 0.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40e1
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Elitegroup Computer Systems Unknown device 0f69
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 58
	Region 4: I/O ports at ec00 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Elitegroup Computer Systems Unknown device 0f69
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 66
	Region 4: I/O ports at e880 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Elitegroup Computer Systems Unknown device 0f69
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 50
	Region 4: I/O ports at e800 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Elitegroup Computer Systems Unknown device 0f69
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 74
	Region 4: I/O ports at e480 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Elitegroup Computer Systems Unknown device 0f69
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 50
	Region 0: Memory at ffefbc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=06, subordinate=07, sec-latency=32
	Memory behind bridge: ff500000-ffdfffff
	Prefetchable memory behind bridge: 00000000ddf00000-00000000dfe00000
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR+
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 02)
	Subsystem: Elitegroup Computer Systems Unknown device 0f69
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controller IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Elitegroup Computer Systems Unknown device 0f69
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 233
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
	Subsystem: Elitegroup Computer Systems Unknown device 0f69
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 0400 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc Unknown device 7145 (prog-if 00 [VGA])
	Subsystem: Elitegroup Computer Systems Unknown device 0f69
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at ff3f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at ff3c0000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <4us, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16

03:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5789 Gigabit Ethernet PCI Express (rev 11)
	Subsystem: Elitegroup Computer Systems Unknown device 0f58
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at ff4f0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: bbdefbef8cfdfdf4  Data: f77e
	Capabilities: [d0] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <4us, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 4096 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
		Link: Latency L0s <4us, L1 <64us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1

06:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG Network Connection (rev 05)
	Subsystem: Intel Corporation Unknown device 2702
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 6000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 233
	Region 0: Memory at ffdfe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

06:07.0 FireWire (IEEE 1394): O2 Micro, Inc. Unknown device 00f7 (rev 02) (prog-if 10 [OHCI])
	Subsystem: O2 Micro, Inc. Unknown device 00f7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at ff500000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at ffdfc800 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

06:07.2 Class 0805: O2 Micro, Inc. Unknown device 7120 (rev 01)
	Subsystem: Unknown device 0001:0000
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at ffdfc400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:07.3 Mass storage controller: O2 Micro, Inc. Unknown device 7130 (rev 01)
	Subsystem: Unknown device 0001:0000
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ffdff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------030602090002090703060808--
