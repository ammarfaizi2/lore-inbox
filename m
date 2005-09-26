Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbVIZMbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbVIZMbe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbVIZMbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:31:34 -0400
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:3201 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S1751408AbVIZMbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:31:33 -0400
Message-ID: <4337EA12.1070001@tremplin-utc.net>
Date: Mon, 26 Sep 2005 14:31:14 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.6-6mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dmitry pervushin <dpervushin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
Subject: Re: SPI
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
In-Reply-To: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

09/26/2005 01:12 PM, dmitry pervushin wrote/a écrit:
> Hello guys,
> 
> I am attaching the next incarnation of SPI core; feel free to comment it.
Hello,

Very little comments...


> Index: linux-2.6.10/drivers/spi/Kconfig
> ===================================================================
> --- /dev/null
> +++ linux-2.6.10/drivers/spi/Kconfig
> @@ -0,0 +1,33 @@
> +#
> +# SPI device configuration
> +#
> +menu "SPI support"
> +
> +config SPI
> +	default Y
> +	tristate "SPI support"
> +        default false
> +	help
> +	  Say Y if you need to enable SPI support on your kernel
SPI is far from being well know, please put more help. At least define 
SPI as "Serial Peripheral Interface" and suggest the user to have a look 
at Documentation/spi.txt . IMHO, it's also convenient if you give the 
name of the module that will be created (spi?).


> Index: linux-2.6.10/Documentation/spi.txt
> ===================================================================
> --- /dev/null
> +++ linux-2.6.10/Documentation/spi.txt
:
:
> +
> +1. What is SPI ?
> +----------------
> +SPI stands for "Serial Peripheral Interface", a full-duplex synchronous 
> +serial interface for connecting low-/medium-bandwidth external devices 
> +using four wires. SPI devices communicate using a master/slave relation-
> +ship over two data lines and two control lines:
> +- Master Out Slave In (MOSI): supplies the output data from the master 
> +  to the inputs of the slaves;
> +- Master In Slave Out (MISO): supplies the output data from a slave to 
> +  the input of the master. It is important to note that there can be no 
> +  more than one slave that is transmitting data during any particular 
> +  transfer;
> +- Serial Clock (SCLK): a control line driven by the master, regulating 
> +  the flow of data bits;
> +- Slave Select (SS): a control line that allows slaves to be turned on 
> +  and off with  hardware control.
> +More information is also available at http://en.wikipedia.org/wiki/Serial_Peripheral_Interface/ .
Broken link, it is 
http://en.wikipedia.org/wiki/Serial_Peripheral_Interface (no trailing /)


Cheers,
Eric
