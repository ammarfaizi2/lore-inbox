Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWGYWwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWGYWwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWGYWwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:52:08 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:31429 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1030210AbWGYWwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:52:07 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] CCISS: Don't print driver version until we actually find a device
Date: Tue, 25 Jul 2006 16:51:59 -0600
User-Agent: KMail/1.8.3
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mike Miller <mike.miller@hp.com>, iss_storagedev@hp.com,
       linux-kernel@vger.kernel.org
References: <200607251636.42765.bjorn.helgaas@hp.com> <9a8748490607251543w7496864dtd587abc45b93394a@mail.gmail.com> <1153867675.8932.68.camel@laptopd505.fenrus.org>
In-Reply-To: <1153867675.8932.68.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607251651.59697.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 July 2006 16:47, Arjan van de Ven wrote:
> On Wed, 2006-07-26 at 00:43 +0200, Jesper Juhl wrote:
> > On 26/07/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > > If we don't find any devices, we shouldn't print anything.
> > >
> > I disagree.
> > I find it quite nice to be able to see that the driver loaded even if
> > it finds nothing. At least then when there's a problem, I can quickly
> > see that at least it is not because I didn't forget to load the
> > driver, it's something else. Saves time since I can start looking for
> > reasons why the driver didn't find anything without first spending
> > additional time checking if I failed to cause it to load for some
> > reason.
> 
> I'll add a second reason: it is a REALLY nice property to be able to see
> which driver is started last in case of a crash/hang, so that the guilty
> party is more obvious..

initcall_debug is a more reliable way to find that.  Do you want
all drivers to print something in their init function?  Right now,
there's really no consistency.  My guess is that the majority don't
print anything until a device is found.  But I admit I didn't try
to count them.
