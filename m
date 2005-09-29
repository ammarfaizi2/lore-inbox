Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVI2TX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVI2TX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVI2TX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:23:59 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:42770 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932399AbVI2TX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:23:58 -0400
Message-ID: <433C3F48.8020404@tmr.com>
Date: Thu, 29 Sep 2005 15:23:52 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rio: switch to ANSI prototypes
References: <20050929152208.GA18132@mipter.zuzino.mipt.ru> <20050929152556.GU7992@ftp.linux.org.uk> <20050929165236.GC18132@mipter.zuzino.mipt.ru> <20050929165259.GV7992@ftp.linux.org.uk>
In-Reply-To: <20050929165259.GV7992@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Thu, Sep 29, 2005 at 08:52:36PM +0400, Alexey Dobriyan wrote:
> 
>>On Thu, Sep 29, 2005 at 04:25:56PM +0100, Al Viro wrote:
>>
>>>Uh-oh...  Well, if you want to play with it...  FWIW, I'm disabling rio as
>>>hopeless FPOS; if you feel masochistic, go ahead but keep in mind that its
>>>handling of tty glue is severely b0rken.
>>
>>Well, duh... It clutters _my_ logs.
> 
> 
> diff -urN RC13-git12-nfs-endian/drivers/char/Kconfig RC13-git12-rio/drivers/char/Kconfig
> --- RC13-git12-nfs-endian/drivers/char/Kconfig	2005-09-10 15:41:34.000000000 -0400
> +++ RC13-git12-rio/drivers/char/Kconfig	2005-09-12 14:50:05.000000000 -0400
> @@ -282,12 +282,13 @@
>  
>  config RIO
>  	tristate "Specialix RIO system support"
> -	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
> +	depends on SERIAL_NONSTANDARD && BROKEN
>  	help
>  	  This is a driver for the Specialix RIO, a smart serial card which
>  	  drives an outboard box that can support up to 128 ports.  Product
>  	  information is at <http://www.perle.com/support/documentation.html#multiport>.
>  	  There are both ISA and PCI versions.
> +	  Note that while card might be smart, driver most certainly isn't.

Funniest comment line of the month ;-)

But if you have a need for something like this, the bad driver is better 
than none, and marked BROKEN it may actually get some attention.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
