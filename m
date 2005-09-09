Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVIIQTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVIIQTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVIIQTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:19:20 -0400
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:10171 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S1750745AbVIIQTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:19:19 -0400
Message-ID: <4321B5F6.4040707@lifl.fr>
Date: Fri, 09 Sep 2005 18:19:02 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.6-5mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: viro@zeniv.linux.org.uk
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bogus #if (acpi/blacklist)
References: <20050909160723.GI9623@ZenIV.linux.org.uk>
In-Reply-To: <20050909160723.GI9623@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

09/09/2005 06:07 PM, viro@zeniv.linux.org.uk wrote/a écrit:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ----
> diff -urN RC13-git8-base/drivers/acpi/blacklist.c current/drivers/acpi/blacklist.c
> --- RC13-git8-base/drivers/acpi/blacklist.c	2005-09-08 23:42:49.000000000 -0400
> +++ current/drivers/acpi/blacklist.c	2005-09-09 11:28:44.000000000 -0400
> @@ -73,7 +73,7 @@
>  	{""}
>  };
>  
> -#if	CONFIG_ACPI_BLACKLIST_YEAR
> +#ifdef	CONFIG_ACPI_BLACKLIST_YEAR
>  
>  static int __init blacklist_by_year(void)
>  {

Are you sure about this? IIRC, CONFIG_ACPI_BLACKLIST_YEAR is defined to 
0 when it should not be blacklisted. In drivers/acpi/Kconfig :
     Enter 0 to disable this mechanism and allow ACPI to
     run by default no matter what the year.  (default)


Eric
