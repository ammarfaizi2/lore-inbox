Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269819AbUJGOa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269819AbUJGOa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269697AbUJGO3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:29:04 -0400
Received: from iona.labri.fr ([147.210.8.143]:41365 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S269671AbUJGO2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:28:46 -0400
Date: Thu, 7 Oct 2004 16:28:42 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stuart MacDonald <stuartm@connecttech.com>,
       "=?iso-8859-1?Q?'S=E9bastien?= Hinderer'" 
	<Sebastien.Hinderer@libertysurf.fr>,
       rmk@arm.linux.org.uk,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] new serial flow control
Message-ID: <20041007142841.GB2158@bouh.labri.fr>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Stuart MacDonald <stuartm@connecttech.com>,
	=?iso-8859-1?Q?'S=E9bastien?= Hinderer' <Sebastien.Hinderer@libertysurf.fr>,
	rmk@arm.linux.org.uk,
	'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
References: <043c01c4ac0d$2c8bac80$294b82ce@stuartm> <1097154020.31614.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1097154020.31614.22.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu 07 oct 2004 à 14:00:24 +0100, Alan Cox a tapoté sur son clavier :
> In this mode the DTE end (host normally) asserts RTS to request 
> transmit access to the link. The DCE asserts CTS to indicate it has
> finished sending bits, and the DTE then transmits.
> 
> RTS is a direction selector (RTS = 0, DCE transmit) (RTS = 1, DTE
> transmit). CTS acts as the handshake to deal with the link turn around.

Hum... It seems like every role is inverted with TVB: _TVB_ raises
_CTS_ to request transmit access. The _PC_ then raises _RTS_ to
indicate it has finished sending bits, TVB then transmits.

(Yes, the cabling is correct: that's the way the DOS driver works)

Regards,
Samuel
