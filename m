Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbUBTUIo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbUBTUEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 15:04:40 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:37803 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S261408AbUBTUCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 15:02:00 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Linux-2.6.3 : [eth0: Too much work at interrupt, status=0x00000001.]
Date: Fri, 20 Feb 2004 20:01:58 +0000
User-Agent: KMail/1.5.4
Cc: YOSHIFUJI Hideaki / ____________ <yoshfuji@linux-ipv6.org>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <200402201803.12146.andrew@walrond.org> <200402201915.09342.andrew@walrond.org> <20040220113427.0a088fb9@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040220113427.0a088fb9@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402202001.58343.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 Feb 2004 7:34 pm, Stephen Hemminger wrote:
>
> The driver needs to be converted to NAPI to sustain high network loads.
> The existing driver allocates and copies each receive packet in the
> interrupt routine.
>
> See the recent revision of 8139too to see what that entails.

Yes but...there were no high network loads. Just me typing into ssh.

STOP PRESS....FIX...

That may well be so, but I rebuilt the kernel with the optional MMIO on the 
rhine driver, and the messages have disappeared.

I have also used wget to fetch a 100Mb file at an average 1.02Mb/s and it 
worked flawlessly and still no warnings in dmesg.

Andrew Walrond

