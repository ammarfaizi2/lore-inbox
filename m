Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311647AbSC2Tmw>; Fri, 29 Mar 2002 14:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311670AbSC2Tmo>; Fri, 29 Mar 2002 14:42:44 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:39942 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S311647AbSC2Tme>; Fri, 29 Mar 2002 14:42:34 -0500
Date: Fri, 29 Mar 2002 14:42:34 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Stanislav Meduna <stano@meduna.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: USB printing via ptal broke between 2.4.17 and .18
Message-ID: <20020329144234.E23430@sventech.com>
In-Reply-To: <200203291936.g2TJaWT02200@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2002, Stanislav Meduna <stano@meduna.org> wrote:
> somewhere between 2.4.17 and 2.4.18 the USB printing to the
> HP printer using PTAL library broke. I now get following
> in the log:
> 
> ptal-init: Starting the HP OfficeJet Linux driver.
> ptal-mlcd: SYSLOG at ExMgr.cpp:660, dev=<usb:PSC_750>, pid=1183, errno=111
>         ptal-mlcd successfully initialized. 
> ptal-printd: ptal-printd(mlc:usb:PSC_750) successfully initialized. 
> rc: Starting ptal-init:  succeeded
> ptal-mlcd: ERROR at ExMgr.cpp:2445, dev=<usb:PSC_750>, pid=1183, errno=11
>         llioService: llioRead returns 3, expected=6! 
> ptal-mlcd: ERROR at ExMgr.cpp:853, dev=<usb:PSC_750>, pid=1183, errno=32
>         exClose(reason=0x0010) 
> 
> Any idea what I should try to further corner the bug?
> 
> Red Hat 7.2
> 2.4.18 kernel
> hpoj 0.8
> hpijs 1.0
> HP PSC 750 multifunctional device
> alias usb-controller uhci
> no devfs

Give usb-uhci a shot. I'm curious if it works better.

Also, can you try the latest 2.4.19 pre patch (-pre4 I believe)?

JE

