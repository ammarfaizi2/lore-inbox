Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTEWO3A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 10:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTEWO3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 10:29:00 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:31397 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S264009AbTEWO2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 10:28:52 -0400
Subject: Re: [2.5.69] rtnl-deadlock with usermodehelper and keventd
From: Stian Jordet <liste@jordet.nu>
To: "David S. Miller" <davem@redhat.com>
Cc: lists@mdiehl.de, akpm@digeo.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, jt@hpl.hp.com, shemminger@osdl.org
In-Reply-To: <20030523.024308.94566989.davem@redhat.com>
References: <20030522.235905.42785280.davem@redhat.com>
	 <Pine.LNX.4.44.0305230934490.14825-100000@notebook.home.mdiehl.de>
	 <20030523.024308.94566989.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1053700957.711.3.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 23 May 2003 16:42:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 23.05.2003 kl. 11.43 skrev David S. Miller:
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

And so it did :-) Thanks.

Best regards,
Stian

