Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272564AbTGZRCl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 13:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272569AbTGZRCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 13:02:41 -0400
Received: from [216.208.38.106] ([216.208.38.106]:64762 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id S272564AbTGZRCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 13:02:31 -0400
Date: Sat, 26 Jul 2003 14:20:48 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Voicu Liviu <pacman@mscc.huji.ac.il>
Cc: alexander.riesen@synopsys.COM, linux-kernel@vger.kernel.org
Subject: Re: IPX support to kernel 2.6
Message-ID: <20030726172048.GB1189@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Voicu Liviu <pacman@mscc.huji.ac.il>, alexander.riesen@synopsys.COM,
	linux-kernel@vger.kernel.org
References: <3F1FAE0C.4090608@mscc.huji.ac.il> <20030724135347.GK13611@Synopsys.COM> <3F1FDB97.7060907@mscc.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1FDB97.7060907@mscc.huji.ac.il>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 24, 2003 at 04:13:59PM +0300, Voicu Liviu escreveu:
> Alex Riesen wrote:
> >Voicu Liviu, Thu, Jul 24, 2003 11:59:40 +0200:
> >>Problem:
> >>
> >>Hi guys, I wanted to add IPX support to kernel 2.6 in order to mount 
> >>novell volumes but it seems not tu exist!
> >
> >It is renamed:
> >ANSI/IEEE 802.2 - aka LLC (IPX, Appletalk, Token Ring)
> >under Networking support/Networking options.
> >
> Wow, I appreciate your help

It was not renamed, it just requires that LLC be selected first, then one has
to select IPX as before.

I plan to make the LLC1 part, that is all that is needed for IPX, Appletalk and
Token Ring to be separated from the big llc module, and making those depending
only on LLC1 to be top level in the config, triggering the selection of LLC1
automatically, this will help as well on not having to have LLC2 when all one
wants is IPX, Appletalk or Token Ring.

- Arnaldo
