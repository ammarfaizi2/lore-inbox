Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVFPIgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVFPIgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 04:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVFPIgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 04:36:19 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:16818 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261199AbVFPIgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 04:36:14 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: USB flash "drive" is not working sometimes
Date: Thu, 16 Jun 2005 11:35:42 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       gregkh@suse.de, dbrownell@users.sourceforge.net,
       mdharm-usb@one-eyed-alien.net
References: <200506160933.01195.vda@ilport.com.ua> <20050616005152.15b34cfd.zaitcev@redhat.com>
In-Reply-To: <20050616005152.15b34cfd.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506161135.42392.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 June 2005 10:51, Pete Zaitcev wrote:
> On Thu, 16 Jun 2005 09:33:01 +0300, Denis Vlasenko <vda@ilport.com.ua> wrote:
> 
> > 2005-06-16_05:23:09.81176 kern.debug: uhci_hcd 0000:00:1f.4: port 1 portsc 0093,00
> > 2005-06-16_05:23:09.81179 kern.debug: hub 2-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
> > 2005-06-16_05:23:09.91495 kern.debug: hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
> > 2005-06-16_05:23:09.99598 kern.info: usb 2-1: new full speed USB device using uhci_hcd and address 2
> > 2005-06-16_05:23:09.99944 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_control: failed with status 440000
> > 2005-06-16_05:23:09.99963 kern.debug: [ce4a7240] link (0e4a71b2) element (0ddbf040)
> > 2005-06-16_05:23:09.99966 kern.debug:   0: [cddbf040] link (0ddbf080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=0e653b80)
> > 2005-06-16_05:23:09.99972 kern.debug:   1: [cddbf080] link (0ddbf0c0) e3 SPD Active Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=0e46c9a0)
> > 2005-06-16_05:23:09.99976 kern.debug:   2: [cddbf0c0] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
> 
> The 440000 is a timeout in most cases. Unsurprisingly, it ends with:
> 
> > 2005-06-16_05:23:10.24285 kern.err: usb 2-1: device descriptor read/64, error -71
> 
> At this point the device is toast, the microcontroller is not running.

Do you mean: "this is a problem with the stick. Sometimes its
electronics simply do not work at first plug in" ?

Can USB controller momentarily cut power to the stick, thus electrically
simulating a replug? I'd likr to try something like this.

> > I remove flash and reinsert:
> 
> > 2005-06-16_06:11:11.24079 kern.info: usb 2-1: new full speed USB device using uhci_hcd and address 6
> >[...]
> > 2005-06-16_06:11:11.35987 kern.debug: usb 2-1: default language 0x0409
> > 2005-06-16_06:11:11.36661 kern.debug: usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=3
> 
> Well, duh.
--
vda

