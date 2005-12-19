Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVLSVae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVLSVae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 16:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVLSVae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 16:30:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965004AbVLSVad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 16:30:33 -0500
Date: Mon, 19 Dec 2005 13:30:22 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: Lee Revell <rlrevell@joe-job.com>, Hansjoerg Lipp <hjlipp@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] isdn4linux: add drivers for Siemens Gigaset ISDN
 DECT PABX
Message-ID: <20051219133022.173a8b92@localhost.localdomain>
In-Reply-To: <43A70882.80106@imap.cc>
References: <20051212181356.GC15361@hjlipp.my-fqdn.de>
	<43A6E209.5030406@imap.cc>
	<1135011676.20747.3.camel@mindpipe>
	<43A70882.80106@imap.cc>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2005 20:22:42 +0100
Tilman Schmidt <tilman@imap.cc> wrote:

> On 2005-12-19 18:01, Lee Revell wrote:
> > On Mon, 2005-12-19 at 17:38 +0100, Tilman Schmidt wrote:
> > 
> >>Unfortunately these don't fit our needs, as we are not dealing with a
> >>network device, but with an ISDN device.
> > 
> > Um, isn't that what the N in ISDN stands for?
> 
> While the ISDN is indeed called a network, devices connecting a computer
> to it are nevertheless not commonly referred to as network devices.
> 
> > I guess what you mean is that although ISDN devices are obviously
> > networking devices, the kernel uses a separate subsystem for ISDN?
> 
> There's more to it than that. The notion of a "network" is a rather
> broad one, including such diverse phenomena as Ethernet, ISDN, TV cable
> or even roads or TV stations. The notion of a "network device", on the
> other hand, is a quite specific one, at least in the computer world, and
> it certainly doesn't include ISDN TAs.
> 
> In fact, the operation of an ISDN device is much closer to a modem or
> even an answering machine than to that prototypical network device which
> is the Ethernet card. This is of course the reason why the Linux kernel
> puts them in a subsystem of their own. Making them net_device-s just
> wouldn't work.
> 


My definition is simple. Any device driver that exports a netdevice
interface needs to be reviewed on netdev to make sure the assumptions
about network device semantics are being followed.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
