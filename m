Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTDHMWp (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 08:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbTDHMWp (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 08:22:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54424
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261328AbTDHMWo (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 08:22:44 -0400
Subject: Re: help writing file system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dave <davekern@ihug.co.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <002501c2fe57$3dfb3b80$0b721cac@stacy>
References: <002501c2fe57$3dfb3b80$0b721cac@stacy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049801752.8118.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Apr 2003 12:35:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-09 at 06:16, dave wrote:
> My report files work like this
>     1. OPEN
>         Memory is allocated and status information is loaded into the memory
>     2. READ
>         Normal read of the memory (report)
>     5. RELASE
>         The report memory is freed
> 
> so now I want my driver when is starts to make an mount point in /proc/lnvrm
> and then

/proc doesnt work that way. /proc works on the basis that each read
generates a new fake set of data, reports it and frees it.

> 1. how do you make a mount point in /proc ?

Just make a directory, you can mount over /proc/foo if you wish

> 2. how do you auto mount that point ?

You dont. You let the user do it

> 3     how do you make a device node in proc ? (I wont use this but it is
> interesting to me)

You dont

All this is actually a lot easier in 2.5 with libfs/sysfs for managing
system objects.

Alan

