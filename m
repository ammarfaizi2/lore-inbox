Return-Path: <linux-kernel-owner+w=401wt.eu-S1751909AbXAVPRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbXAVPRo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXAVPRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:17:44 -0500
Received: from h155.mvista.com ([63.81.120.155]:34986 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751909AbXAVPRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:17:43 -0500
Message-ID: <45B4D592.9050703@ru.mvista.com>
Date: Mon, 22 Jan 2007 18:17:38 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Eric.Piel@lifl.fr, akpm@osdl.org, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
References: <20070119.121910.96686038.nemoto@toshiba-tops.co.jp>	<20070119.125751.104030382.nemoto@toshiba-tops.co.jp>	<45B4C2DA.8020906@lifl.fr> <20070122.233251.74752372.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070122.233251.74752372.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Atsushi Nemoto wrote:

> Subject: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
> 
> CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
> might result in allocation failure for the reserving itself on some
> platforms (for example typical 32bit MIPS).  Make it (and
> CARDBUS_IO_SIZE too) customizable by "pci=" option for such platforms.

    Sorry for grammatic nitpicking. :-)

> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 25d2985..dc39989 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1259,6 +1259,12 @@ and is between 256 and 4096 characters.
>  				This sorting is done to get a device
>  				order compatible with older (<= 2.4) kernels.
>  		nobfsort	Don't sort PCI devices into breadth-first order.
> +		cbiosize=nn[KMG]	The fixed amount of bus space which is
> +				reserved for the CardBus bridges IO window.

    It shoyld be "bridge's"...

> +				The default value is 256 bytes.
> +		cbmemsize=nn[KMG]	The fixed amount of bus space which is
> +				reserved for the CardBus bridges memory window.

    Ditto.

> +				The default value is 64 megabytes.
>  

MBR, Sergei
