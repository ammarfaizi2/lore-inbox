Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTEWQdH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 12:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbTEWQdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 12:33:07 -0400
Received: from palrel10.hp.com ([156.153.255.245]:30604 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264095AbTEWQdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 12:33:06 -0400
Date: Fri, 23 May 2003 09:46:08 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: lists@mdiehl.de, akpm@digeo.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, jt@hpl.hp.com, shemminger@osdl.org
Subject: Re: [2.5.69] rtnl-deadlock with usermodehelper and keventd
Message-ID: <20030523164608.GC17288@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030522.235905.42785280.davem@redhat.com> <Pine.LNX.4.44.0305230934490.14825-100000@notebook.home.mdiehl.de> <20030523.024308.94566989.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030523.024308.94566989.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 02:43:08AM -0700, David S. Miller wrote:
>    From: Martin Diehl <lists@mdiehl.de>
>    Date: Fri, 23 May 2003 11:38:38 +0200 (CEST)
> 
>    On Thu, 22 May 2003, David S. Miller wrote:
>    
>    >    Asking just because there was another user hitting this deadlock:
>    > 
>    > It's fixed in current 2.5.x sources, wake up :-)
>    
>    Oops, sorry for the noise, I hadn't noticed this yet.
>    
>    But nope, unfortunately it's still hanging! I've just tested with 
>    2.5.69-bk15. Running into the same deadlock due to sleeping with rtnl 
>    hold. This time however it seems it's triggered from sysfs side!
> 
> Stephen, you need to do the device class stuff outside of the RTNL
> lock please.
> 
> At least I didn't add this bug :-)
> 
> This should fix it.

	Thanks Dave, we are very much obliged !

	Jean
