Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVASRIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVASRIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVASRIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:08:47 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:723 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261701AbVASRIq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:08:46 -0500
From: David Brownell <david-b@pacbell.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: usbmon, usb core, ARM
Date: Wed, 19 Jan 2005 09:08:34 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
References: <20050118212033.26e1b6f0@localhost.localdomain> <200501182214.25273.david-b@pacbell.net> <20050119074208.3bfa6458@localhost.localdomain>
In-Reply-To: <20050119074208.3bfa6458@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501190908.35210.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 January 2005 7:42 am, Pete Zaitcev wrote:
> 		Relying on pipe makes
> tests dependant on URB only. No references to bus or HCD, therefore no
> extra refcounts or worries about oopses. Also, HC drivers zero out the
> urb->dev in giveback sequence which is a royal pain when trying to identify
> a root hub.

That was a 2.4-ism, it should now be gone.  So an inlined function to
test whether urb->dev is the root hub should suffice; I know there's
code that does that already.

- Dave
