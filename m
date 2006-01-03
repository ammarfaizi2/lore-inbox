Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWACV1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWACV1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWACV1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:27:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24755 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964953AbWACV06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:26:58 -0500
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
From: Arjan van de Ven <arjan@infradead.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1136323485.10862.74.camel@localhost.localdomain>
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <20051230080002.GA7438@kroah.com>
	 <1135984304.13318.50.camel@serpentine.pathscale.com>
	 <20051231001051.GB20314@kroah.com>
	 <1135993250.13318.94.camel@serpentine.pathscale.com>
	 <20060103172732.GA9170@kroah.com>
	 <1136321691.10862.61.camel@localhost.localdomain>
	 <1136321851.2869.18.camel@laptopd505.fenrus.org>
	 <1136323485.10862.74.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 22:26:54 +0100
Message-Id: <1136323614.2869.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Perhaps read/write on the character device file would be preferable to
> ioctls for sending and receiving these management packets?  We don't
> implement those file methods at the moment, so it's not like we'd be
> displacing anything.

if it's just data packets.. you could implement a device that offers the
SG_IO interface. Yes it's ioctls, but it's a preexisting ABI so I
suspect that's not too big a deal (and maybe you can even leverage a lot
of existing code for this)


