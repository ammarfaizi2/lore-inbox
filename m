Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272611AbTG1BkB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272231AbTG1BjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 21:39:00 -0400
Received: from rth.ninka.net ([216.101.162.244]:32899 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S272315AbTG1Bhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 21:37:31 -0400
Date: Sun, 27 Jul 2003 18:52:41 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: allow 2.6 to build on old old setups
Message-Id: <20030727185241.3288a973.davem@redhat.com>
In-Reply-To: <200307272026.h6RKQauS029828@hraefn.swansea.linux.org.uk>
References: <200307272026.h6RKQauS029828@hraefn.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 21:26:36 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> +#ifdef STT_REGISTER
>  		if (info->hdr->e_machine == EM_SPARC ||
>  		    info->hdr->e_machine == EM_SPARCV9) {
>  			/* Ignore register directives. */
>  			if (ELF_ST_TYPE(sym->st_info) == STT_REGISTER)
>  				break;
>  		}
> +#endif

This change is wrong.

If you're going to do this, it's much better to define it to the
correct value in this case (which is decimal '13').
