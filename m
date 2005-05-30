Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVE3XPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVE3XPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVE3XOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:14:54 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:55524 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261811AbVE3XMS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:12:18 -0400
X-ORBL: [69.107.40.98]
From: David Brownell <david-b@pacbell.net>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] Re: [BUG] oops while completing async USB via usbdevio
Date: Mon, 30 May 2005 16:12:07 -0700
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, Harald Welte <laforge@gnumonks.org>,
       linux-kernel@vger.kernel.org
References: <20050530194443.GA22760@sunbeam.de.gnumonks.org> <200505301555.39985.david-b@pacbell.net> <200505310109.06445.oliver@neukum.org>
In-Reply-To: <200505310109.06445.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200505301612.07850.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 May 2005 4:09 pm, Oliver Neukum wrote:
> Am Dienstag, 31. Mai 2005 00:55 schrieb David Brownell:
> > The logic closing an open usbfs file -- which is done before any task
> > exits with such an open file -- is supposed to block till all its URBs
> > complete.  So the pointer to the task "should" be valid for as long as
> > any URB it's submitted is active.
> 
> What happens if you pass such an fd through a socket?

Why I suppose then you might find glitches in the design underlying
the usbfs code.  I put "should" in scare-quotes for a reason.

