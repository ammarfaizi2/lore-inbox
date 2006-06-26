Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWFZPrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWFZPrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWFZPrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:47:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61370 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750715AbWFZPrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:47:11 -0400
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
	i386
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060626153834.GA18599@redhat.com>
References: <20060626151012.GR23314@stusta.de>
	 <20060626153834.GA18599@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 17:46:55 +0200
Message-Id: <1151336815.3185.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 11:38 -0400, Dave Jones wrote:
> On Mon, Jun 26, 2006 at 05:10:12PM +0200, Adrian Bunk wrote:
>  > virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
>  > on i386.
>  > 
>  > Without such warnings people will never update their code and fix 
>  > the errors in PPC64 builds.
> 
> .. and deprecating pm_send_all, cli, sti, restore_flags, check_region yadayada
> has really been a great success at motivating people to fix those up too.

cli/sti should just be removed, or at least have those drivers marked
BROKEN... nobody is apparently using them anyway...


Maybe depreciation needs to go together with a "will mark users broken
in X days, and will remove entirely in X+Y days".. and then stick to
it. 

