Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTGHQ1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 12:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbTGHQ1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 12:27:11 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:25731 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264592AbTGHQ1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 12:27:05 -0400
Date: Tue, 8 Jul 2003 18:41:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vincent Touquet <vincent.touquet@pandora.be>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030708184132.A25510@ucw.cz>
References: <20030706210243.GA25645@lea.ulyssis.org> <20030708161406.GJ14044@ns.mine.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030708161406.GJ14044@ns.mine.dnsalias.org>; from vincent.touquet@pandora.be on Tue, Jul 08, 2003 at 06:14:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 06:14:06PM +0200, Vincent Touquet wrote:
> By the way, I'm having the same problem as described in here too:
> http://www.cs.helsinki.fi/linux/linux-kernel/2003-21/0619.html
> 
> Perhaps time we took another look at the AMD 74xx ide code ?
> Or is this particular bug considered harmless ?

Most likely caused by the slave devices confusing the BIOS cable
detection. The amd74xx driver can only use what the BIOS tells it. You
can use 'ide0=ata66' to override the cable detection.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
