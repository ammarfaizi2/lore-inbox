Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUHHUFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUHHUFv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 16:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUHHUFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 16:05:50 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:27341 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S266233AbUHHUFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 16:05:49 -0400
Date: Sun, 8 Aug 2004 22:05:32 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: [2/3] via-rhine: de-isolate PHY
Message-ID: <20040808200532.GA19170@k3.hellgate.ch>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
References: <411684D5.8020302@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411684D5.8020302@colorfullife.com>
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ BCCed reporter in case he wants to weigh in on the issue ]

On Sun, 08 Aug 2004 21:53:57 +0200, Manfred Spraul wrote:
> Roger wrote:
> 
> >PHYs may come up isolated. Make sure we can send data to them. This code
> >section needs a clean-up, but I prefer to merge this fix in isolation.
> >
> What was the phyid value for the isolated PHYs?

I suspect it was 0, because another suggestion in the same message was to
start scanning at 0 rather than 1 (obsolete with current via-rhine code).

> I know that PHYs go into isolate mode if the startup id is wired to 0, 

Wouldn't that be s/go/can go/ ?

> but I haven't figured out what's necessary to initialize them: Just 
> clear the isolate bit or is it necessary to set the id to a nonzero value.

The proposed fix apparently worked for the PHY in question (LSI Logic
80225).

Roger
