Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267134AbTAPPJw>; Thu, 16 Jan 2003 10:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbTAPPJw>; Thu, 16 Jan 2003 10:09:52 -0500
Received: from 195-95-38-150.KPNBelgium.be ([195.95.38.150]:46065 "HELO
	mail.vt4.net") by vger.kernel.org with SMTP id <S267134AbTAPPJv>;
	Thu, 16 Jan 2003 10:09:51 -0500
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: Irda connectivity problems since 2.4.20
Date: Thu, 16 Jan 2003 16:16:05 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301161616.05993.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I recently switched my debian install over from 2.4.19 to 2.4.20. Since then 
I've been having trouble syncing my Palm m500 over Irda. It works, but the 
transfers seem to stall a lot, making the total hotsync take over 5 minutes 
to complete.

The irda transfers work fine in 2.4.19.

These are the messages in the dmesg:

ircomm_tty_attach_cable()
ircomm_tty_ias_register()
irlap_state_ndm(), media busy!
irlap_change_speed(), setting speed to 115200
irlmp_state_dtr(), Unknown event LM_LAP_CONNECT_CONFIRM
ircomm_param_service_type(), services in common=04
ircomm_param_service_type(), resulting service type=0x04
ircomm_param_xon_xoff(), XON/XOFF = 0x11,0x13
ircomm_param_enq_ack(), ENQ/ACK = 0x13,0x11
ircomm_tty_check_modem_status()
ircomm_param_xon_xoff(), XON/XOFF = 0x11,0x13
ircomm_param_enq_ack(), ENQ/ACK = 0x13,0x11
ircomm_tty_check_modem_status()
irlmp_state_dtr(), Unknown event LM_WATCHDOG_TIMEOUT
Framing or parity error!
Framing or parity error!
Framing or parity error!
... lots of framing errors

<here the transfer stalls and JPilot hangs>

after half a minute the transfer continues, only to stall later again.

I'm using the following irda related modules:
irtty irport ircomm-tty ircomm irda

Any ideas?

Thanks!

DK
