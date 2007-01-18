Return-Path: <linux-kernel-owner+w=401wt.eu-S1750788AbXARXYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbXARXYe (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 18:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXARXYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 18:24:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:60285 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbXARXYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 18:24:33 -0500
From: Andi Kleen <ak@suse.de>
To: Alexey Dobriyan <adobriyan@openvz.org>
Subject: Re: [PATCH] Print number of oopses in Sysrq-P output
Date: Fri, 19 Jan 2007 10:19:56 +1100
User-Agent: KMail/1.9.1
Cc: Pavel Emelianov <xemul@openvz.org>, devel@openvz.org,
       linux-kernel@vger.kernel.org
References: <20070118170522.GA23679@localhost.sw.ru>
In-Reply-To: <20070118170522.GA23679@localhost.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701191019.57030.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 January 2007 04:05, Alexey Dobriyan wrote:

> @@ -292,9 +292,11 @@ __setup("idle=", idle_setup);
>  void show_regs(struct pt_regs * regs)
>  {
>  	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
> +	extern int die_counter;

externs should always be in some .h file, never in a sub scope.

-Andi
