Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVL1MLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVL1MLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 07:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVL1MLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 07:11:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55011 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964798AbVL1MLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 07:11:47 -0500
Subject: Re: Badness in isar_pump_statev_fax
From: Arjan van de Ven <arjan@infradead.org>
To: Dietmar Kling <dietmar.kling@sam-net.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43B27F9A.2060807@sam-net.de>
References: <43B27F9A.2060807@sam-net.de>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 13:11:38 +0100
Message-Id: <1135771898.2935.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 13:05 +0100, Dietmar Kling wrote:
> Hi,
> 
> during the holidays i tried to reactivate my old fax card,
> but i get a kind of oops in the system log. Fax is received, so
> is this really something to worry about?
> (cpuinfo, lspci is attached)


this is an mdelay(2) (or more depending on ioctls) in irq context...
that's naughty and nasty for latencies and potentially for time
keeping..

(but it's not an "immediate crash" kind of thing, just really sloppy/bad
code)

