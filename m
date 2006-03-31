Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWCaR5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWCaR5m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWCaR5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:57:41 -0500
Received: from isilmar.linta.de ([213.239.214.66]:47550 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932166AbWCaR5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:57:41 -0500
Date: Fri, 31 Mar 2006 19:57:39 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Jeremy Johnson <acj.pllc.law@verizon.net>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: pcmciautils Kyocera KPC650
Message-ID: <20060331175739.GA25504@isilmar.linta.de>
Mail-Followup-To: Jeremy Johnson <acj.pllc.law@verizon.net>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1303.192.168.1.47.1143662778.squirrel@www.acjlaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1303.192.168.1.47.1143662778.squirrel@www.acjlaw.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 29, 2006 at 03:06:18PM -0500, Jeremy Johnson wrote:
> # lspci -v|grep subordinate
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64 Bus:
> primary=00, secondary=05, subordinate=05, sec-latency=64 Bus:
> primary=05, secondary=06, subordinate=09, sec-latency=176
> which looks OK since my yenta_socket is 0000:05:09.0

No. The CPU (which is connected via the host bridge) tries to access the
_newly created_ bus with bus numer 06 -- and it can't find a way to it, as
the first bridge only exports bus 01-01 below it, and the second one (the
one in front of the yenta socket) only exports bus 05-05, not 05-09 which it
should. Therefore, please try pci=assign-busses.

	Dominik
