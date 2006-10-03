Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWJCNB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWJCNB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 09:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWJCNB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 09:01:59 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:8926 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S932096AbWJCNB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 09:01:58 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: error to be returned while suspended
Date: Tue, 3 Oct 2006 15:02:33 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200610031323.00547.oliver@neukum.org> <Pine.LNX.4.61.0610030846040.21211@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0610030846040.21211@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610031502.33545.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 3. Oktober 2006 14:51 schrieb linux-os (Dick Johnson):
> 
> On Tue, 3 Oct 2006, Oliver Neukum wrote:
> 
> > Hi,
> >
> > which error should a character device return if a read/write cannot be
> > serviced because the device is suspended? Shouldn't there be an error
> > code specific to that?
> >
> > 	Regards
> > 		Oliver
> 
> The de-facto error codes were created long before one could "suspend"
> a device, so there isn't a ESUSP code. However, I suggest EIO or EBUSY

CUPS chokes on these. Is it acceptable to say that you should know
what you're doing when suspending?

> unless you want to define an ESUSP and get it accepted by the POSIX
> committee.

This would be the cleanest solution. How does one do that?

	Regards
		Oliver
