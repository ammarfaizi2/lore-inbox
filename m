Return-Path: <linux-kernel-owner+w=401wt.eu-S1750959AbWLLIAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWLLIAr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 03:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWLLIAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 03:00:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43156 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbWLLIAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 03:00:46 -0500
Subject: Re: [PATCH] Whinge in paging_init if noexec is on with a non-PAE
	kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Kyle McMartin <kyle@ubuntu.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061212023805.GE4044@athena.road.mcmartin.ca>
References: <20061212000359.GB4044@athena.road.mcmartin.ca>
	 <20061212023805.GE4044@athena.road.mcmartin.ca>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 12 Dec 2006 09:00:38 +0100
Message-Id: <1165910438.27217.555.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 21:38 -0500, Kyle McMartin wrote:
> On second thought, this is probably better since most people will
> presumably be booting non-PAE kernels, generating this message when
> they've not tried to force the issue seems silly.


why not go the simple way, and just remove noexec=on entirely?
If your cpu can use NX, it'll get used automatically, and if not, it
won't. There's never any use for passing noexec=on .. at all since it
has no effect whatsoever.


