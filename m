Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946463AbWJSUeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946463AbWJSUeb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946468AbWJSUea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:34:30 -0400
Received: from mail.suse.de ([195.135.220.2]:64981 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946463AbWJSUea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:34:30 -0400
Date: Thu, 19 Oct 2006 13:34:09 -0700
From: Greg KH <gregkh@suse.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       R.E.Wolff@BitWizard.nl, Amit Gud <gud@eth.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1 try #2] Char: correct pci_get_device changes
Message-ID: <20061019203409.GB8468@suse.de>
References: <1966866new061818079@muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1966866new061818079@muni.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 04:44:31PM +0200, Jiri Slaby wrote:
> correct pci_get_device changes
> 
> Commits 881a8c120acf7ec09c90289e2996b7c70f51e996 and
> efe1ec27837d6639eae82e1f5876910ba6433c3f corrects pci device matching in
> only one way; it no longer oopses/crashes, despite hotplug is not solved in
> these changes.
> 
> Whenever pci_find_device -> pci_get_device change is performed, also
> pci_dev_get and pci_dev_put should be in most cases called to properly
> handle hotplug. This patch does exactly this thing -- increase refcount to
> let kernel know, that we are using this piece of HW just now.
> 
> It affects moxa and rio char drivers.
> 
> Cc: <R.E.Wolff@BitWizard.nl>
> Cc: Amit Gud <gud@eth.net>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
