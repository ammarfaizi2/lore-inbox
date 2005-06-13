Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVFMGNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVFMGNM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 02:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVFMGNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 02:13:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15270 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261311AbVFMGNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 02:13:09 -0400
Subject: Re: [Patch][RFC] fcntl: add ability to stop monitored processes
From: Arjan van de Ven <arjan@infradead.org>
To: Neil Horman <nhorman@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050612181006.GC2229@hmsendeavour.rdu.redhat.com>
References: <20050611000548.GA6549@hmsendeavour.rdu.redhat.com>
	 <20050611180715.GK24611@parcelfarce.linux.theplanet.co.uk>
	 <20050611193500.GC1097@devserv.devel.redhat.com>
	 <20050612181006.GC2229@hmsendeavour.rdu.redhat.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 08:13:04 +0200
Message-Id: <1118643185.5260.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-12 at 14:10 -0400, Neil Horman wrote:
> How about this?  Its the same feature, with an added check in fcntl_dirnotify to
> ensure that only processes with CAP_SYS_ADMIN set can tell processes preforming
> the monitored actions to stop.

SIGSTOP is kinda rude I think though..... I mean, how do you suppose you
restart said processes again? manual sysadmin work?

