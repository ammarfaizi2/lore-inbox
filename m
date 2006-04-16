Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWDPDsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWDPDsm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 23:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWDPDsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 23:48:42 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.8]:30215 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932197AbWDPDsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 23:48:42 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: SATA Conflict with PATA DMA
Date: Sun, 16 Apr 2006 04:48:47 +0100
User-Agent: KMail/1.9.1
Cc: Bill Waddington <william.waddington@beezmo.com>
References: <fa.m9JwGQvLBixssS4UodPQfih6Ygk@ifi.uio.no> <fa.foo0W8w4UdiDztK9eBiA9awyAi8@ifi.uio.no> <p9f2425uijetlpcq49m08cto9la898l80f@4ax.com>
In-Reply-To: <p9f2425uijetlpcq49m08cto9la898l80f@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604160448.47225.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 April 2006 19:38, Bill Waddington wrote:
> On Sat, 15 Apr 2006 16:42:22 UTC, in fa.linux.kernel you wrote:
> >Esben Stien wrote:
> >> I'm having problems enabling DMA for my PATA HD.
> >>
> >> hdparm -d1 /dev/hdb reports:
> >> HDIO_SET_DMA failed: Operation not permitted
> >>
> >> Of course, I'm super user. Nothing is printed in dmesg.
> >>
> >> I'm on linux-2.6.16 and motherboard is Fujitsu Siemens D1561 with an
> >> ICH5. I also have a SATA hd in the computer and this only happens when
> >> the SATA hd is there. If I remove the SATA HD, then I can enable DMA
> >> for the PATA hd.
> >
> >Disabled combined mode in BIOS.
>
> If only that was possible on my fscking T43.  *sigh*

Not sure if this is universal, but if Linux doesn't claim the PATA interface, 
the SATA seems to drive optical drives on (presumably) the other channel 
(ICH7 here, on a Dell laptop with a similar BIOS limitation).

Try CONFIG_IDE=n and boot with libata.atapi_enable=1 and see what happens...

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
