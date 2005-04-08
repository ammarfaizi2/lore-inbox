Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVDHWMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVDHWMg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVDHWMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:12:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:45995 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261162AbVDHWMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:12:32 -0400
Date: Fri, 8 Apr 2005 15:12:05 -0700
From: Greg KH <greg@kroah.com>
To: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 'is_enabled' flag should be set/cleared when the device is actually enabled/disabled
Message-ID: <20050408221205.GC3399@kroah.com>
References: <42561C5B.2060507@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42561C5B.2060507@soft.fujitsu.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 02:53:31PM +0900, Kenji Kaneshige wrote:
> Hi,
> 
> I think 'is_enabled' flag in pci_dev structure should be set/cleared
> when the device actually enabled/disabled. Especially about
> pci_enable_device(), it can be failed. By this change, we will also
> get the possibility of refering 'is_enabled' flag from the functions
> called through pci_enable_device()/pci_disable_device().
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

Ah, nice catch.  I've applied this to my trees now, thanks.

greg k-h
