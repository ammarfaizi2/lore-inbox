Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265075AbUEUWlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbUEUWlD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbUEUWkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:40:35 -0400
Received: from CPE-139-168-157-129.nsw.bigpond.net.au ([139.168.157.129]:33020
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S266080AbUEUWdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:14 -0400
Message-ID: <40AC7B0E.5090401@eyal.emu.id.au>
Date: Thu, 20 May 2004 19:31:58 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27-pre3 - `irqreturn_t' previously declared
References: <20040518203039.GA9970@logos.cnet>
In-Reply-To: <20040518203039.GA9970@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Hi, 
> 
> Here goes the third pre of 2.4.27. 

  gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DMODULE -DMODVERSIONS -include /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ips  -c -o ips.o ips.c
In file included from ips.c:180:
ips.h:99: redefinition of `irqreturn_t'
/data2/usr/local/src/linux-2.4-pre/include/linux/interrupt.h:16: `irqreturn_t' previously declared here
make[2]: *** [ips.o] Error 1
make[2]: Leaving directory `/data2/usr/local/src/linux-2.4-pre/drivers/scsi'


--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
