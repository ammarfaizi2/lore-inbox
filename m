Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWDFS7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWDFS7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 14:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWDFS7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 14:59:36 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:27779 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S932125AbWDFS7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 14:59:35 -0400
Subject: Re: [PATCH] Fix pciehp driver on non ACPI systems
From: Dave Hansen <dave@sr71.net>
To: Greg KH <greg@kroah.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, anton@samba.org, akpm@osdl.org,
       gregkh@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060406182722.GA31712@kroah.com>
References: <20060406101731.GA9989@krispykreme>
	 <20060406160527.GA2965@kroah.com>
	 <20060406104113.08311cdc.rdunlap@xenotime.net>
	 <20060406182722.GA31712@kroah.com>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 11:58:58 -0700
Message-Id: <1144349938.9731.185.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-06 at 11:27 -0700, Greg KH wrote:
> Would that solve this issue?  I'm guessing that they are being included
> as it needs something in those headers... 

There's another #ifdef CONFIG_ACPI area in the .c file.  I doubt
anything else in there really needs ACPI.  Maybe the #ifdef'd area could
go into its own _acpi.c file?

-- Dave

