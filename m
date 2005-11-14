Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVKNVFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVKNVFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVKNVFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:05:34 -0500
Received: from web52901.mail.yahoo.com ([206.190.49.11]:24203 "HELO
	web52901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932126AbVKNVFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:05:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=gpN6RyUydvyE4W0O8grnrtXe2TkEtSpIGZaNjYiZ8e/kx/ul58yXFJ3uYaZOqqLfHfcCoWGaz4PIRt3ZMnHKCOVomqwJD0jVfzfv0ZQmtHay9rA3LzHe1cCcHVcCcZfs3TxrEwnKIBzNJzKQAP81smWZjgTSK1VMq8P/5iFeHmk=  ;
Message-ID: <20051114210530.5657.qmail@web52901.mail.yahoo.com>
Date: Mon, 14 Nov 2005 21:05:29 +0000 (GMT)
From: Chris Rankin <rankincj@yahoo.com>
Subject: [OOPS] Linux 2.6.14.2 and DVB USB
To: linux-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My Linux 2.6.14.2-SMP kernel has just exploded on me, after I detached my USB2 DVB USB adapter.
This is on a UP PIII 1GHz Coppermine machine. There was a storm of:

dvb-usb: bulk message failed: -19 (2/0)

messages between the disconnection and the eventual oops. Note also that the DVB device was
attached to a USB2 hub.

Cheers,
Chris

usb 5-5.4: new high speed USB device using ehci_hcd and address 21
dvb-usb: found a 'Hauppauge WinTV-NOVA-T usb2' in cold state, will try to load a firmware
dvb-usb: downloading firmware from file 'dvb-usb-nova-t-usb2-01.fw' to the 'Cypress FX2'
dvb-usb: Hauppauge WinTV-NOVA-T usb2 successfully initialized and connected.
usb 5-5.4: USB disconnect, address 21
dvb-usb: generic DVB-USB module successfully deinitialized and disconnected.
usb 5-5.4: new high speed USB device using ehci_hcd and address 22
dvb-usb: found a 'Hauppauge WinTV-NOVA-T usb2' in warm state.
dvb-usb: will pass the complete MPEG2 transport stream to the software demuxer.
DVB: registering new adapter (Hauppauge WinTV-NOVA-T usb2).
dvb-usb: MAC address: 00:0d:fe:03:77:33
dib3000: Found a DiBcom 3000P.
DVB: registering frontend 0 (DiBcom 3000P/M-C DVB-T)...
dvb-usb: schedule remote query interval to 100 msecs.
dvb-usb: Hauppauge WinTV-NOVA-T usb2 successfully initialized and connected.
usb 5-5.4: USB disconnect, address 22
dvb-usb: bulk message failed: -19 (2/0)
dvb-usb: bulk message failed: -19 (2/0)
dvb-usb: Hauppauge WinTV-NOVA-T usb2 successfully deinitialized and disconnected.
dvb-usb: bulk message failed: -19 (2/0)
dvb-usb: bulk message failed: -19 (2/0)
dvb-usb: bulk message failed: -19 (2/0)
...
dvb-usb: bulk message failed: -19 (2/0)
dvb-usb: bulk message failed: -19 (2/0)
dvb-usb: bulk message failed: -19 (2/0)
Unable to handle kernel paging request at virtual address bd83b3c4
 printing eip:
bd83b3c4
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: dvb_usb_nova_t_usb2 dvb_usb_dibusb_common dib3000mc dib3000_common dvb_usb
dvb_core firmware_class dvb_pll snd_usb_audio snd_usb_lib snd_seq_oss snd_seq_midi
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul mga drm ipv6
floppy snd_pcm_oss snd_mixer_oss snd_seq binfmt_misc matroxfb_maven i2c_matroxfb i2c_algo_bit loop
w83781d hwmon_vid i2c_isa eeprom ide_cd cdrom psmouse pcspkr button processor nfs nfsd exportfs
lockd parport_pc parport ehci_hcd eth1394 ohci_hcd ohci1394 ieee1394 8139too mii emu10k1_gp
gameport snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_ac97_bus
snd_page_alloc snd_util_mem snd_hwdep snd soundcore i2c_i801 i2c_core uhci_hcd usbcore i8xx_tco
intel_agp agpgart sunrpc ext3 jbd
CPU:    0
EIP:    0060:[<bd83b3c4>]    Not tainted VLI
EFLAGS: 00010206   (2.6.14.2)
EIP is at 0xbd83b3c4
eax: 3d373417   ebx: 3d373417   ecx: d498b0b8   edx: c0354000
esi: 00000200   edi: c1405de0   ebp: bd83b3c4   esp: c0354fb0
ds: 007b   es: 007b   ss: 0068
Process setiathome_4.02 (pid: 12144, threadinfo=c0354000 task=d67375a0)
Stack: c0124de2 00000002 010b8f60 00000000 c0317cc0 c0354000 c0354fc8 c0354fc8
       c034007b 00000001 c0317cc8 c034dee0 00000000 c0120ab0 0000000a d647efb0
       00000046 0001a952 bf80d458 c010505f
Call Trace:
 [<c0124de2>] run_timer_softirq+0xe2/0x1c0
 [<c0120ab0>] __do_softirq+0x80/0x100
 [<c010505f>] do_softirq+0x4f/0x60
 =======================
 [<c01038c4>] apic_timer_interrupt+0x1c/0x24
Code:  Bad EIP value.
 <0>Kernel panic - not syncing: Fatal exception in interrupt




		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
