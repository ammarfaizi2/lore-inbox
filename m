Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265550AbUALOk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 09:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUALOk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 09:40:28 -0500
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:200 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S265550AbUALOk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 09:40:26 -0500
Message-ID: <4002B1D9.872714FE@moving-picture.com>
Date: Mon, 12 Jan 2004 14:40:25 +0000
From: James Pearson <james-p@moving-picture.com>
Organization: Moving Picture Company
X-Mailer: Mozilla 4.7 [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.0 NFS-server low to 0 performance
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> På lau , 10/01/2004 klokka 11:08, skreiv Andi Kleen:
> > Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> > 
> > > The correct solution to this problem is (b). I.e. we convert mount to
> > > use TCP as the default if it is available. That is consistent with what
> > > all other modern implementations do.
> > 
> > Please do that. Fragmented UDP with 16bit ipid is just russian roulette at 
> > today's network speeds.
> 
> I fully agree.
> 
> Chuck Lever recently sent an update for the NFS 'mount' utility to
> Andries. Among other things, that update changes this default. We're
> still waiting for his comments.

If mount defaults to trying TCP first then UDP if the TCP mount fails,
should there be separate options for [rw]size depending on what type of
mount actually takes place? e.g. 'ursize' and 'uwsize' for UDP and
'trsize' and 'twsize' for TCP ?

James Pearson
