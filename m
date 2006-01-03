Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWACU5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWACU5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWACU5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:57:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33674 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932523AbWACU5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:57:37 -0500
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
From: Arjan van de Ven <arjan@infradead.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <1136321691.10862.61.camel@localhost.localdomain>
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <20051230080002.GA7438@kroah.com>
	 <1135984304.13318.50.camel@serpentine.pathscale.com>
	 <20051231001051.GB20314@kroah.com>
	 <1135993250.13318.94.camel@serpentine.pathscale.com>
	 <20060103172732.GA9170@kroah.com>
	 <1136321691.10862.61.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 21:57:31 +0100
Message-Id: <1136321851.2869.18.camel@laptopd505.fenrus.org>
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

On Tue, 2006-01-03 at 12:54 -0800, Bryan O'Sullivan wrote:
> On Tue, 2006-01-03 at 09:27 -0800, Greg KH wrote:
> 
> > Idealy, nothing should be new ioctls.  But in the end, it all depends on
> > exactly what you are trying to do with each different one.
> 
> Fair enough.
> 
> > I really don't know what the subnet management stuff involves, sorry.
> > But doesn't the open-ib layer handle that all for you already?
> 
> It does when our OpenIB driver is being used.  But our lower level
> driver is independent of OpenIB (and is often used without the
> infiniband stuff even configured into the kernel), and needs to provide
> some way for a userspace subnet management agent to send and receive
> packets.

that sounds like your driver should mimic the openIB userspace ABI for
this *exactly* so that you can use the same management tools for either
scenario...


