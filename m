Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVJQWMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVJQWMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVJQWMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:12:47 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:53909
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932317AbVJQWMq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:12:46 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>
In-Reply-To: <Pine.LNX.4.10.10510171503520.24518-100000@godzilla.mvista.com>
References: <Pine.LNX.4.10.10510171503520.24518-100000@godzilla.mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 18 Oct 2005 00:15:04 +0200
Message-Id: <1129587304.19559.154.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 15:05 -0700, Daniel Walker wrote:
> 
> On Tue, 18 Oct 2005, Thomas Gleixner wrote:
> 
> > On Mon, 2005-10-17 at 14:43 -0700, Daniel Walker wrote:
> > > I found this latency ~5 minutes after boot up, no load . It looks like
> > > vgacon_scroll() has a memset like operation which can grow. 
> > 
> > 5 minutes after bootup could also be related to a jiffies wrap problem. 
> > 
> 
> I saw it multiple times , but this trace was the biggest .. It looks like
> it might be related to CONFIG_PRINTK_IGNORE_LOGLEVEL .. I don't see how
> jiffies could be related though .

Ah, ok. I just pointed to that as I trapped several times into the 5
minutes wrap already.

	tglx


