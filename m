Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbTBHXuS>; Sat, 8 Feb 2003 18:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbTBHXuS>; Sat, 8 Feb 2003 18:50:18 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5290
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267128AbTBHXuR>; Sat, 8 Feb 2003 18:50:17 -0500
Subject: Re: 2.4.21-pre4 comparison bugs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030208171838.GA2230@linuxhacker.ru>
References: <20030208171838.GA2230@linuxhacker.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044752320.18908.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Feb 2003 00:58:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-08 at 17:18, Oleg Drokin wrote:
> -	if((autodma = ide_setup_pci_controller(dev, d, noisy, &tried_config)) < 0)
> +	if((int)(autodma = ide_setup_pci_controller(dev, d, noisy, &tried_config)) < 0)
>  		return index;

Well caught. I don't like your fix. I'd prefer to do the job properly
and either make it return a signed value or split error/value reporting
in these various cases.

I'll fix them for the next -ac

