Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266238AbUAGQQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUAGQQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:16:53 -0500
Received: from ltgp.iram.es ([150.214.224.138]:45443 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S266238AbUAGQOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:14:00 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 7 Jan 2004 17:04:44 +0100
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-BK9 and DC21142/3
Message-ID: <20040107160444.GA4723@iram.es>
References: <20040102160640.GA3453@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102160640.GA3453@rdlg.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 11:06:41AM -0500, Robert L. Harris wrote:
> 
> 
>   I just installed 2.4.23-bk9 on a system with a ethernet card that
> lscpi reports as DC21142 which is a quad port card.  When the machine
> came up it auto negotiated half duplex instead of full.  On 2.4.21-ac4
> it negotiated Full.

What driver are you using? 

I've had some similar problems recently and had to increase the 
autonegotiation timeout in a network driver to make the result of the 
autonegotiation stable, otherwise sometimes it would be HD sometimes FD.
The reason was apparently that the driver would fall back to another
method of determining the link speed and this other method limited
itself to half duplex. I even seem to remember that it occasionally 
decided to fall back to 10Mb/s half duplex...

It also may depend on the switches and the MII transceiver brand 
you use, the combinations I have now seems especially slow at 
autonegotiation. I have 2 sets of very similar systems, 6 of one
kind and 4 of another. The first 6 have the same exact components 
(DC21140 with National MII transceiver) AFAICT but a slightly 
different PCB revision it seems, the slightly older ones are more 
affected than later revisions. The last 4 are strictly identical:
DC21143 with Level One (now Intel AFAIR) transceivers, and all 4
behave identically.

At least it does not seem to depend on the phase of the moon :-)

I'm still using 2.2 with de4x5 driver, but there were very few 
differences with the 2.4 version of the driver last time I looked.

	Gabriel


