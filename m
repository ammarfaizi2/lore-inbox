Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbUC3S7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbUC3S7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:59:53 -0500
Received: from cpc3-hitc2-5-0-cust51.lutn.cable.ntl.com ([81.99.82.51]:60342
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S263830AbUC3S7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:59:50 -0500
Message-ID: <406996C2.4030204@reactivated.net>
Date: Tue, 30 Mar 2004 16:48:18 +0100
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22Fr=E9d=E9ric_L=2E_W=2E_Meunier=22?= 
	<1@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rmmod deadlocks with 2.6.5-rc[2,3]
References: <Pine.LNX.4.58.0403301529590.1233@pervalidus.dyndns.org>
In-Reply-To: <Pine.LNX.4.58.0403301529590.1233@pervalidus.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Frédéric L. W. Meunier wrote:
> If I boot with 2.6.5-rc[2,3] and use rmmod snd_via82xx or rmmod
> ohci_hcd (it doesn't happen with all modules), rmmod deadlocks.
> 2.6.4 works fine.

The ohci_hcd problem should be temporarily fixed by a recent patch to this 
list, from Greg KH (subject: [PATCH] USB: Eliminate wait following interface 
unregistration). This worked for me.

As for the snd_ modules, this is a different problem, which I am still 
experiencing. I have had it with both snd_emu10k1 and snd_intel8x0 - but it 
does not happen every time. I have experienced it on 2.6.5-rc2 and -rc3 (plus 
their -mm patches). rmmod hangs and doesnt respond to kill -9.

Is there any output I can capture to diagnose this?

Daniel
