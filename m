Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264438AbTIJDfb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 23:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbTIJDfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 23:35:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:43185 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264438AbTIJDf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 23:35:27 -0400
Date: Tue, 9 Sep 2003 20:35:24 -0700
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: Dave Jones <davej@redhat.com>, Anatoly Pugachev <mator@gsib.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: agpgart support for intel SHG2 motherboard, serverworks chipset
Message-ID: <20030910033524.GD9760@kroah.com>
References: <20030905000452.GF12613@kroah.com> <Pine.LNX.4.44.0309091658400.17200-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309091658400.17200-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 05:22:00PM -0500, Matt Domsch wrote:
> > > Anatoly, I've cc'd Greg on this one, as you managed to break the
> > > sysfs new_id stuff that he wrote, so I think he may be interested
> > > in fixing that up 8-)
> 
> agp_serverworks_probe() is marked __init.  Thus the static lookup 
> called by the new_id code fails as this function is no longer in the 
> kernel.  The fix is to remove __init from the probe routines.  I'm looking 
> to see how often this occurs elsewhere.

Ah, Russell just got a patch for this into the tree today.

thanks,

greg k-h
