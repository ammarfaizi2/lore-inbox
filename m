Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132396AbRDPW6C>; Mon, 16 Apr 2001 18:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132398AbRDPW5w>; Mon, 16 Apr 2001 18:57:52 -0400
Received: from quattro.sventech.com ([205.252.248.110]:37895 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S132396AbRDPW5m>; Mon, 16 Apr 2001 18:57:42 -0400
Date: Mon, 16 Apr 2001 18:57:41 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: FAVRE Gregoire <greg@ulima.unil.ch>, linux-kernel@vger.kernel.org
Subject: Re: USB with 2.4.3-ac{1,3,7} without devfs
Message-ID: <20010416185740.Y4295@sventech.com>
In-Reply-To: <20010417004248.A19914@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <20010417004248.A19914@ulima.unil.ch>; from FAVRE Gregoire on Tue, Apr 17, 2001 at 12:42:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should probably bring up things like this on the Linux USB list.

On Tue, Apr 17, 2001, FAVRE Gregoire <greg@ulima.unil.ch> wrote:
> Under 2.4.3 I manage uploading photo from my Digital IXUS using USB_UHCI
> with s10h, but under ac series, I don't manage, only other things I have
> changed is removing devfs which I don't need in fact...
[snip]
> And as I power on my camera:
> 
> hub.c: USB new device connect on bus1/1, assigned device number 2
> usb_control/bulk_msg: timeout
> usb.c: USB device not accepting new address=2 (error=-110)
> hub.c: USB new device connect on bus1/1, assigned device number 3
> usb_control/bulk_msg: timeout
> usb.c: USB device not accepting new address=3 (error=-110)

What does /proc/interrupts show for the 2.4.3-ac7 case?

[snip]
> I don't think, because under 2.4.3 with devfs, /dev/usb is empty...
> 
> Thanks you in advance for your help,

s10sh doesn't use anything under /dev, it's all under /proc/bus/usb,
however, you are having a problem before it gets to s10sh at all.

JE

