Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTKSTNe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 14:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTKSTNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 14:13:34 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:26631 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263956AbTKSTNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 14:13:32 -0500
Date: Wed, 19 Nov 2003 20:13:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, Matt Domsch <Matt_Domsch@dell.com>,
       Jeff Garzik <jgarzik@pobox.com>, Jason Holmes <jholmes@psu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make 2.6 megaraid recognize intel vendor id
Message-ID: <20031119191327.GA1053@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matt Domsch <Matt_Domsch@dell.com>, Jeff Garzik <jgarzik@pobox.com>,
	Jason Holmes <jholmes@psu.edu>, linux-kernel@vger.kernel.org
References: <3FB3BBE0.D4D0EACC@psu.edu> <3FB3D5B1.5080904@pobox.com> <20031113153552.A20514@lists.us.dell.com> <20031119131627.A12116@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119131627.A12116@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, nice rewrite.

Minor comments - which is not not specific for ypur clean-up, but maybe
worth addressing now?

> +#ifdef CONFIG_PROC_FS
> +	if (adapter->controller_proc_dir_entry) {
> +		remove_proc_entry("stat", adapter->controller_proc_dir_entry);
> +		remove_proc_entry("config",
> +				adapter->controller_proc_dir_entry);
remove_proc_entry is an empty do {} while, so the ifdef is not needed.

> +#if MEGA_HAVE_ENH_PROC
Looks like a potential CONFIG option?

> +#ifdef CONFIG_PROC_FS
> +	remove_proc_entry("megaraid", &proc_root);
> +#endif
ifdef not needed.

	Sam
