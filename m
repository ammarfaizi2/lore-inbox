Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVCaUDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVCaUDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 15:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVCaUDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 15:03:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:16574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbVCaUDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 15:03:09 -0500
Message-ID: <424C5745.7020501@osdl.org>
Date: Thu, 31 Mar 2005 12:02:13 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: ioe-lkml@axxeo.de, matthew@wil.cx, lkml <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, hadi@cyberus.ca, cfriesen@nortel.com, tgraf@suug.ch
Subject: Re: [RFC/PATCH] network configs: disconnect network options from
 drivers
References: <20050330234709.1868eee5.randy.dunlap@verizon.net> <20050331185226.GA8146@mars.ravnborg.org>
In-Reply-To: <20050331185226.GA8146@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Wed, Mar 30, 2005 at 11:47:09PM -0800, Randy.Dunlap wrote:
> 
>>- some Networking options need to be qualified with CONFIG_NET
> 
> You can something along the lines os:
> 
> menu "Networking options and protocols"
>   
> config NET
> 	bool "Networking support"
> 	default y
> 
> if NET
> 
> ...
> 
> menu "Network device support"
> ...
> endmenu
> 
> ...
> 
> endif
> endmenu
> 
> Then everything wrapped in between if NET/endif is dependent on NET
> without stating this explicitly.
> You will alos have the menu nice indented.

Yes, sounds good, thanks.

And I'll look into Thomas's suggestions.

Other than "sounds good," are there some comments on:

a.  leaving IrDA and Bluetooth subsystem (with drivers) where they
     are, which is under "Network options and protocols"
	(I really don't want to split their drivers away from their
	subsystem, just to put them under Network driver support.)

b.  leaving SLIP, PPP, and PLIP where they are under Network driver
     support, even though they say that they are "protocols" ?

Any others?

Thanks,
-- 
~Randy
