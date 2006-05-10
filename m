Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWEJVDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWEJVDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWEJVDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:03:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:40169 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964853AbWEJVDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:03:15 -0400
Date: Wed, 10 May 2006 13:56:00 -0700
From: Greg KH <gregkh@suse.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, trenn@suse.de,
       thoenig@suse.de
Subject: Re: [RFC] [PATCH] Execute PCI quirks on resume from suspend-to-RAM
Message-ID: <20060510205600.GB23446@suse.de>
References: <446139FF.205@gmx.net> <20060510093942.GA12259@elf.ucw.cz> <4461C0CA.8080803@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4461C0CA.8080803@gmx.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 12:30:34PM +0200, Carl-Daniel Hailfinger wrote:
> 
> Thinking about it again, if we restored the full pci config space
> on resume, this quirk handling would be completely unnecessary.
> Any reasons why we don't do that?

We do do that.  Look at pci_restore_state().

Actually, look at it in the latest -mm tree, that version works better
than mainline does right now :)

thanks,

greg k-h
