Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264830AbUEEWeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbUEEWeM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbUEEWeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:34:12 -0400
Received: from mail1.kontent.de ([81.88.34.36]:22170 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264830AbUEEWeC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:34:02 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Subject: Re: Load hid.o module synchronously?
Date: Thu, 6 May 2004 00:33:49 +0200
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <s5g8ygi4l3q.fsf@patl=users.sf.net> <20040504200147.GA26579@kroah.com> <s5ghduvdg1u.fsf@patl=users.sf.net>
In-Reply-To: <s5ghduvdg1u.fsf@patl=users.sf.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405060033.49380.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 4. Mai 2004 23:56 schrieb Patrick J. LoPresti:
> Ideally, what I would like is for "modprobe <driver>" to wait until
> all hardware handled by that driver is either ready for use or is
> never going to be.  That seems simple and natural to me.  But I would

The set of devices connected to the machine is not static. Waiting until
all hardware is ready is very hard to even define.

> be glad to use any other mechanism to achieve the same effect; I just
> have not seen one yet.

Issue ioctl() USBDEVFS_CONNECT through usbfs. It does a synchronous
probe for a specific device.

	Regards
		Oliver

