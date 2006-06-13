Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWFMNJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWFMNJj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 09:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWFMNJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 09:09:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7577 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932087AbWFMNJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 09:09:38 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: David Woodhouse <dwmw2@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060613124944.GA16171@merlin.emma.line.org>
References: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl>
	 <1150189506.11159.93.camel@shinybook.infradead.org>
	 <20060613104557.GA13597@merlin.emma.line.org>
	 <1150201475.12423.12.camel@hades.cambridge.redhat.com>
	 <20060613124944.GA16171@merlin.emma.line.org>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 14:10:54 +0100
Message-Id: <1150204255.12423.32.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 14:49 +0200, Matthias Andree wrote:
> Separating tasks into distinct processes, to prevent rampant list
> drivers from messing with the MTA and vice versa.

We're talking about _one_ task; receiving mail to one address, and
delivering it to other addresses. That's what the MTA _does_ -- all it
needs from the mailing list side is the list of recipients.

I wouldn't want to put all the bounce processing &c into the MTA, but
basic handling of list traffic does make a certain amount of sense. In
expanding a simple list, there isn't much scope for 'rampant list
drivers' to screw anything up.

> I'm also not convinced greylisting is a "solution". Once it catches on,
> spammers will retry. They control enough drones where smashing out
> successful deliveries from their address list and retrying them will
> work for them. 

You may be right. But still, it keeps us ahead of the game and it's very
effective right now -- partly because lots of people still _aren't_
using it. It does require a modicum of clue to implement.

I think it'll be a long time before greylisting is no longer beneficial,
if it ever does happen.

-- 
dwmw2

