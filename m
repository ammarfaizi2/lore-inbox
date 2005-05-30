Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVE3XLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVE3XLd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVE3XKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:10:35 -0400
Received: from mail1.kontent.de ([81.88.34.36]:64929 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261816AbVE3XJI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:09:08 -0400
From: Oliver Neukum <oliver@neukum.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [BUG] oops while completing async USB via usbdevio
Date: Tue, 31 May 2005 01:09:06 +0200
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, Harald Welte <laforge@gnumonks.org>,
       linux-kernel@vger.kernel.org
References: <20050530194443.GA22760@sunbeam.de.gnumonks.org> <20050530212641.GE25536@sunbeam.de.gnumonks.org> <200505301555.39985.david-b@pacbell.net>
In-Reply-To: <200505301555.39985.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505310109.06445.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 31. Mai 2005 00:55 schrieb David Brownell:
> The logic closing an open usbfs file -- which is done before any task
> exits with such an open file -- is supposed to block till all its URBs
> complete.  So the pointer to the task "should" be valid for as long as
> any URB it's submitted is active.

What happens if you pass such an fd through a socket?

	Regards
		Oliver

