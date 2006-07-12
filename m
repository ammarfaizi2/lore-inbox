Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWGLCqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWGLCqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 22:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWGLCqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 22:46:52 -0400
Received: from Maxwell.derobert.net ([207.188.193.82]:22745 "EHLO
	Maxwell.derobert.net") by vger.kernel.org with ESMTP
	id S932354AbWGLCqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 22:46:51 -0400
Message-ID: <44B46276.5030006@suespammers.org>
Date: Tue, 11 Jul 2006 22:46:14 -0400
From: Anthony DeRobertis <asd@suespammers.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Stephen Hemminger <shemminger@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       341801@bugs.debian.org, kevin@sysexperts.com
Subject: Re: skge error; hangs w/ hardware memory hole
References: <20060703205238.GA10851@deprecation.cyrius.com> <20060707141843.73fc6188@dxpl.pdx.osdl.net> <200607072328.51282.ak@suse.de>
In-Reply-To: <200607072328.51282.ak@suse.de>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAKlBMVEVTAABbAQBsAACAAQCV
 AAC3DwTXPhTrZiLyjiroi133tCn53UX51n/45bb7J7XrAAACZ0lEQVQ4y2WTz07bQBDGlz5BHF6g
 cfoAxeu+QHYd7rDjwD1eK1eq7AbUU6XGVpRroTxBKE8ABs6oKr2itiHv0pldh/zpSJai/WVm55v5
 lgVBsLufFaoT4q8GWwWBGC4VJxBsgjaXqeJRa5MEQRNBLxMupe2KvWk4ELZ5fPxVcB6GYbyHtBm/
 J9AkkGaSf0CWRFjx3YErFRKADJIjUBIURFx2CIQEZKL1eGQ/ApyNVSJFwwOOIAWAdKBktxiKVuhB
 G0E6VhJD8Fjxjm+XzmN59EVy7vrCzwNOhaA3RBA58cux4LlMTy9QoD9/1c7j7rBXDkHU540VSExu
 QGLtjQRGlQzgDMPWRgIB0EouwWq6MYozr2BtU1ImOQH+P0hHmZJ1t+sggTwDSSmbq/UAAJexBQAG
 j9ZolfRbGwD/PHjWJv1TiG2QWioFMtoCvcEzXS5dv2tdAXaLy66FrAPtgKgVrkCqrQZSvi59J3jL
 dD690CtAaAc995mZT+faA29eH7sH7LY0mS/l/e4ijE/YQ2XAXR6LcJkSSjhhi9+GLsdQ9dbR/kPY
 Y4vK6IwA9GufoLe6hxGbz06xX4y8L8hwzsv7irP59VPhARxyT9BRINni/psborOKcym9CgD287sl
 kJdjDzhZGbthTzOrNaR5mXkxnGxzLjirClyf1tbUKrmE41kmIlaVEwKX2ACNmOrkGl89q+6vsFY+
 fTSZA2RMcjh7+DWzNh8V2IIbDN4wJiezxd2VtbZE+X4w+E4zhVLZ4i+CSWFIpAPQc/2xeXVd2MmN
 XQLnvwRH8jK/u5m+FD9w+K4WzuCs0Ab+Ad5UBbueJrnMAAAAAElFTkSuQmCC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here are the results with iommu=force. All of these are copied down
by hand, so please forgive any transcription errors:

2.6.12[1]: Last line displayed on screen is "ata1: dev 0 ATA max
UDMA/133 390721968 sectors, lba48". Then it sits there. Scrolling with
shift-pgup/pgdown works. Control-Alt-Del reboots the machine. According
to /var/log/dmesg, the next line --- which never appears --- should be
"ata1: dev 0 configured for UDMA/133"

2.6.17-1: The kernel panics with a null pointer dereference on loading
uhci_hcd. The addresses given are usb_kick_khud+7, usb_hc_died+106,
pcibios_set_master+30, etc. After the panic, it sits there (just like
2.6.12)

2.6.17-mm6: The last line displayed is "SATA link up 1.5 Gbps SStatus
113 Scontrol 300". It completely hangs: neither scrolling nor
control-alt-del work.


Honestly, should I chuck this board through the window of my nearest
ASUS and/or VIA office, and buy an NForce board?
