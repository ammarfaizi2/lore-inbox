Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbTG1OOG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 10:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270065AbTG1OOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 10:14:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45240 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S267464AbTG1OFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 10:05:21 -0400
Date: Mon, 28 Jul 2003 07:17:28 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: allow 2.6 to build on old old setups
Message-Id: <20030728071728.664051cf.davem@redhat.com>
In-Reply-To: <1059391858.15438.14.camel@dhcp22.swansea.linux.org.uk>
References: <200307272026.h6RKQauS029828@hraefn.swansea.linux.org.uk>
	<20030727185241.3288a973.davem@redhat.com>
	<1059391858.15438.14.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jul 2003 12:30:59 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Llu, 2003-07-28 at 02:52, David S. Miller wrote:
> > >  		    info->hdr->e_machine == EM_SPARCV9) {
> > >  			/* Ignore register directives. */
> > >  			if (ELF_ST_TYPE(sym->st_info) == STT_REGISTER)
> > >  				break;
> > >  		}
> > > +#endif
> > 
> > This change is wrong.
> > 
> > If you're going to do this, it's much better to define it to the
> > correct value in this case (which is decimal '13').
> 
> Its sparc specific stuff so presumably all sparc stuff had the register?
> I can change and resubmit though - no problem

The situation is that, on every platform, one gets the define in
/usr/include/elf.h, it's just that older glibc's lack the define.
