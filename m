Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVH1EpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVH1EpS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 00:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVH1EpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 00:45:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38533 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750988AbVH1EpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 00:45:17 -0400
Date: Sat, 27 Aug 2005 21:45:03 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: dio@qwasartech.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: USB EHCI Problem with Low Speed Devices
 on kernel 2.6.11+
Message-Id: <20050827214503.03056887.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.0508272256010.24489-100000@netrider.rowland.org>
References: <20050827102135.4e0b035d.zaitcev@redhat.com>
	<Pine.LNX.4.44L0.0508272256010.24489-100000@netrider.rowland.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2005 22:57:45 -0400 (EDT), Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sat, 27 Aug 2005, Pete Zaitcev wrote:

> > > Kernel
> > > ======
> > > - 2.6.8, 2.6.11.10 and 2.6.12.4, all show same problem

> > Actually, I suspected that this may be a poorly working Transaction
> > Tranlating (TT) hub. Which then may work on certain versions of
> > Windows.

> It looks to me more like a timing problem with initialization of the
> external high-speed hub.  Try this patch:
> 
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=112439094723976&w=2

Yes, Dominik, please do. The TT was a poor guess, because IIRC 2.6.8
did not have the support for TT, so it could not get it wrong.

But testing this hub elsewhere _and_ replacing it with a borrowed
hub would be a good idea, IMHO.

-- Pete
