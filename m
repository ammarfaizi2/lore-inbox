Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbUK3W12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbUK3W12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUK3W12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:27:28 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:19584
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S262359AbUK3W1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:27:15 -0500
Date: Tue, 30 Nov 2004 14:27:13 -0800
From: Phil Oester <kernel@linuxace.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] misleading error message
Message-ID: <20041130222713.GA8501@linuxace.com>
References: <001101c4d715$25a59470$af00a8c0@BEBEL> <Pine.LNX.4.61.0411302251180.3635@dragon.hygekrogen.localhost> <Pine.LNX.4.53.0411302310080.31695@yvahk01.tjqt.qr> <Pine.LNX.4.61.0411302328450.3635@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411302328450.3635@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 11:29:20PM +0100, Jesper Juhl wrote:
> On Tue, 30 Nov 2004, Jan Engelhardt wrote:
> 
> > >> This may be a BUG REPORT, as I see it, allthough more experienced Linux users
> > >> might think differently:
> > >>
> > >> I compiled built-in support for iptables in my new 2.6.9 kernel, but when my
> > >> legacy firewall does a "modprobe ip_tables" , I get the startling message:
> > >> "FATAL: module ip_tables not found" .
> > >
> > >In my oppinion the message is perfectly clear. You told modprobe to load a
> > >module, the file was not found so it is forced to give up - and that's
> > >exactely what it told you.
> > 
> > So how would you go about finding out whether something is compiled-in?
> > 
> Personally I'd just go check my kernels .config

Or adjust your (broken) firewall script to do something like:

[ -f /proc/net/ip_tables_names ] || modprobe ip_tables

Phil

