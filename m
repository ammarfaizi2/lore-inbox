Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318270AbSGXIHP>; Wed, 24 Jul 2002 04:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSGXIHP>; Wed, 24 Jul 2002 04:07:15 -0400
Received: from mailc.telia.com ([194.22.190.4]:49391 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S318270AbSGXIHO>;
	Wed, 24 Jul 2002 04:07:14 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Vassili Papavassiliou <pvs@NMSU.Edu>, linux-kernel@vger.kernel.org
Subject: Re: USB and PCMCIA drop out simultaneously during heavy data transfers  (2.4.18)
Date: Wed, 24 Jul 2002 10:09:38 +0200
User-Agent: KMail/1.4.5
References: <200207240033.g6O0X8n16845@zeppo.NMSU.Edu>
In-Reply-To: <200207240033.g6O0X8n16845@zeppo.NMSU.Edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200207241009.38517.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 July 2002 02.33, Vassili Papavassiliou wrote:
> Hello,
>     This is a problem I reported on July 19; unfortunately, because of a 
typo, 
> the subject header did not appear. Briefly, during traffic through a PCMCIA 
> card (Ethernet, WiFi, or SCSI adapter), both PCMCIA and USB time out if 
there 
> is any USB activity at the time (such as moving a mouse). Otherwise they can 
> coexist for days. After the timeout PCMCIA cannot be restarted until the USB 
> modules are removed. This makes USB essentially unusable in this machine, as 
> there is always some PC card in use. In 2.2.xx, this issue only showed up 
with 
> CardBus cards.
> 
>     I apologize for reposting, but I think it's a real problem that may only 
> show up in older, slow machines, which is why I haven't seen any references 
to 
> it, and the absence of a subject in my original post probably made it 
useless.
> Details are in the archived original message, e.g. in
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0207.2/0884.html
> 
>     If anybody has any ideas, please CC also to pvs@nmsu.edu and thanks in 
> advance.
>                                                       Vassili Papavassiliou

Your logs shows several
"Jul 18 14:58:33 localhost kernel: wvlan_cs: This is a PrismII card, not a 
Wavelan IEEE card :-( "

I have found that the best driver for PrismII cards is the orinoco, this is my
> lsmod
orinoco_cs              4328   1
orinoco                29408   0  [orinoco_cs]
hermes                  3328   0  [orinoco_cs orinoco]
ds                      6368   1  [orinoco_cs]
yenta_socket            8384   1
pcmcia_core            37984   0  [orinoco_cs ds yenta_socket]
...

I do also use USB, memory card with quite big transfers. And I have never seen 
this problem - I will look for it...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

