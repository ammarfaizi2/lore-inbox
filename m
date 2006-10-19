Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946407AbWJST4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946407AbWJST4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946413AbWJST4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:56:11 -0400
Received: from smtp2.cc.ksu.edu ([129.130.7.16]:470 "EHLO smtp2.cc.ksu.edu")
	by vger.kernel.org with ESMTP id S1946411AbWJST4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:56:09 -0400
Message-ID: <4537D5E1.50705@eth.net>
Date: Thu, 19 Oct 2006 14:45:37 -0500
From: Amit Gud <gud@eth.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       R.E.Wolff@BitWizard.nl, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1 try #2] Char: correct pci_get_device changes
References: <1966866new061818079@muni.cz>
In-Reply-To: <1966866new061818079@muni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
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

Acked-by: Amit Gud <gud@ksu.edu>


AG
-- 
May the source be with you.
http://www.cis.ksu.edu/~gud

