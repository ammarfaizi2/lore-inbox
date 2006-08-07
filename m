Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWHGMmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWHGMmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 08:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWHGMmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 08:42:25 -0400
Received: from relay4.usu.ru ([194.226.235.39]:32691 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S932098AbWHGMmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 08:42:24 -0400
Message-ID: <44D7355A.6020006@ums.usu.ru>
Date: Mon, 07 Aug 2006 18:43:06 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] UTF-8 input: composing non-latin1 characters, and	copy-paste
References: <44D71C25.6090301@ums.usu.ru> <1154953118.25998.31.camel@localhost.localdomain>
In-Reply-To: <1154953118.25998.31.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 7.1.1.2; VDF: 6.35.1.59; host: usu2.usu.ru)
X-AV-Checked: ClamAV using ClamSMTP@relay4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Basically I'd rather see us:
> - Expand the kbd code to support the full set of behaviour (within
> reason). It looks like the old behaviour can be expressed by keeping the
> old format and allowing a new format (or mapping the old to the new when
> the ioctl loads it)
> - Expand the kbd code to allow caps/shift mapping by loaded table
> - Store the true symbol not the glyph so we can cut/paste right
> - Do the render mapping of symbols when needed when we actually render
> 
> That also means we get the right results if you move a live console from
> text mode to graphical mode, or load different fonts and refresh.

Indeed. But I am not the one who originally wrote the patch. I only 
fixed a null-pointer dereference in the original patch, updated for a 
new kernel version, and resubmitted. For me, to do what you suggest, 
requires better understanding of the existing code. I will try, though, 
when I get better time.

-- 
Alexander E. Patrakov
