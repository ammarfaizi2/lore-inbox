Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268515AbRHCKJo>; Fri, 3 Aug 2001 06:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268427AbRHCKJY>; Fri, 3 Aug 2001 06:09:24 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:47521 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S268382AbRHCKJX>; Fri, 3 Aug 2001 06:09:23 -0400
Message-ID: <3B6A7962.B5B586C5@veritas.com>
Date: Fri, 03 Aug 2001 15:43:54 +0530
From: "Amit S. Kale" <akale@veritas.com>
Organization: Veritas Software (India)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rajeev Bector <rajeev_bector@yahoo.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: finding out module name from an address  ?
In-Reply-To: <GIEMIEJKPLDGHDJKJELAGECPCCAA.rajeev_bector@yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajeev Bector wrote:
> 
> Hi,
>   I am trying to write a patched kmalloc() which
> will track the caller function using
> __builtin_return_address(0). From that address,
> is there a clean way to figure out if the address
> belongs to a loadable module and if yes, get
> to the module structure of that module so
> that I can log on the basis of module->name

You can traverse module_list. An element of the
list (struct module) also describes size of the module.
So if an address is between struct module pointer and
struct module pointer + mdoule size, you know that the module
contains the code.

> 
> Thanks
> Rajeev
> 
> _________________________________________________________
> Do You Yahoo!?
> Get your free @yahoo.com address at http://mail.yahoo.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Amit Kale
Veritas Software ( http://www.veritas.com )
