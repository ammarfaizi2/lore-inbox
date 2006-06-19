Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWFSKis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWFSKis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWFSKis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:38:48 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:7141 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932372AbWFSKir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:38:47 -0400
From: Duncan Sands <baldrick@free.fr>
To: juampe <juampe@iquis.com>
Subject: Re: [PATCH 06/13] USBATM: shutdown open connections when disconnected
Date: Mon, 19 Jun 2006 12:38:43 +0200
User-Agent: KMail/1.9.1
Cc: kernel <linux-kernel@vger.kernel.org>
References: <OF39174CF7.B508FCBD-ONC125718F.00407FFC-C125718F.00413F4F@telefonica.es> <44965CC3.1060203@iquis.com> <449660E1.30505@iquis.com>
In-Reply-To: <449660E1.30505@iquis.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191238.43980.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really sorry, this is a patch to 2.6.16 and this kernel version works
> well the speedtouch driver.
> I have problems with 2.6.17 and the speedtocuh driver block the
> conection at some point that  i can't locate.
> 
> wave:~# atmdiag
> Itf       TX_okay   TX_err    RX_okay   RX_err    RX_drop
>   0 AAL0         0         0         0         0         0
>     AAL5    266537         0    198023         1         0
> 
> RX cells don't increment, AFAIK the driver don't manage incoming ATM cells
> 
> How i can dig more into this issue in order to extract  relevant
> information for a bug report?.

Hi Juampe, there were only two changes to the speedtouch driver
between 2.6.16 and 2.6.17: a cosmetic one (change to modinfo
output), and one only affecting people using iso urb support
(are you running with enable_isoc=1?).  So any new problems in
2.6.17 must be coming from elsewhere, such as ATM or USB changes.
I didn't spot any interesting ATM changes, and haven't looked at
the USB changes yet.  Are you sure you don't get the same problem
with 2.6.16?  Also, do you get any interesting messages in your
system logs (eg: check the dmesg output)?

Ciao,

Duncan.
