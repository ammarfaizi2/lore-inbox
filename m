Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751835AbWCNMrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWCNMrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbWCNMrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:47:47 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:54667 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751835AbWCNMrr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:47:47 -0500
Message-ID: <4416BB73.5070801@drzeus.cx>
Date: Tue, 14 Mar 2006 13:47:47 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: Bill Nottingham <notting@redhat.com>, Kay Sievers <kay.sievers@vrfy.org>,
       Andrew Morton <akpm@osdl.org>, ambx1@neo.rr.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
References: <20060301194532.GB25907@vrfy.org>	<4406AF27.9040700@drzeus.cx>	<20060302165816.GA13127@vrfy.org>	<44082E14.5010201@drzeus.cx>	<4412F53B.5010309@drzeus.cx>	<20060311173847.23838981.akpm@osdl.org>	<4414033F.2000205@drzeus.cx>	<20060312172332.GA10278@vrfy.org>	<20060313165719.GB4147@devserv.devel.redhat.com>	<20060313192411.GA23380@vrfy.org>	<20060313222644.GD1311@devserv.devel.redhat.com> <20060314152944.797390cd.vsu@altlinux.ru>
In-Reply-To: <20060314152944.797390cd.vsu@altlinux.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
> BTW, we can change the alias format for PNP device drivers to
>
> 	pnp:*dXXXYYYY*
>
> (note the additional "*" before the device ID).  This would allow us to
> have a single-value "modalias" attribute for PNP logical devices too -
> it would have the form
>
> 	pnp:dXXXYYYYdXXXYYYYdXXXYYYY
>
> (listing all IDs, in this case sorting is not required, because each
> driver will match at most only a single dXXXYYYY entry).
>   

How do you guarantee that the modules are tried in the correct order? Is
it well defined in modprobe that pnp:*dABC0001* would match before
pnp:*dXYZ0001* if the modalias is pnp:dABC0001dXYZ0001 ?

Rgds
Pierre

