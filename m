Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267021AbSLDSyH>; Wed, 4 Dec 2002 13:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267024AbSLDSyH>; Wed, 4 Dec 2002 13:54:07 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:777 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267021AbSLDSyH>; Wed, 4 Dec 2002 13:54:07 -0500
Date: Wed, 4 Dec 2002 19:01:38 +0000
From: John Levon <levon@movementarian.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NMI notifiers for 2.5
Message-ID: <20021204190138.GA31519@compsoc.man.ac.uk>
References: <1039027142.20387.11.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039027142.20387.11.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18JemA-0005sL-00*cR5znPxHBT.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 10:39:02AM -0800, Stephen Hemminger wrote:

> +/* 
> + * Registration for maintance routines that want to do something
> + * on NMI.
> + */
> +extern struct notifier_block *nmi_notifier_list;
> +static inline int register_nmi_notifier(struct notifier_block *nb) {
> +	return notifier_chain_register(&nmi_notifier_list, nb);
> +}

Easy way to confuse the hell out of people...

> +			
> +			notifier_call_chain(&nmi_notifier_list, 0, regs);
> +

... because it's really a lockup detect notifier. Please rethink the
naming

(oh and maintenance not maintance)

regards
john

-- 
"Trolls like content too."
	- Bob Abooey, /.
