Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbTIJOcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264801AbTIJOcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:32:21 -0400
Received: from smtp3.us.dell.com ([143.166.148.134]:30988 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP id S264795AbTIJOcT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:32:19 -0400
Date: Wed, 10 Sep 2003 04:31:51 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@localhost.localdomain
To: Greg KH <greg@kroah.com>
cc: rmk@arm.linux.org.uk, Dave Jones <davej@redhat.com>,
       Anatoly Pugachev <mator@gsib.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: Buggy PCI drivers - do not mark pci_device_id as discardable
 data
In-Reply-To: <20030910042428.GA10134@kroah.com>
Message-ID: <Pine.LNX.4.44.0309100427490.17820-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > At least these have probe functions marked __init in -test5.
> 
> These either need to be marked __devinit and make "new_id" dependant on
> CONFIG_HOTPLUG, or we need to remove the __init marker on these
> functions.
> 
> Any throughts about which?

I expect the CONFIG_EMBEDDED folks would much prefer the 
__devinit/CONFIG_HOTPLUG path, so it all disappears for them.

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

