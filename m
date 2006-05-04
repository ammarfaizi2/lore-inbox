Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWEDWWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWEDWWq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 18:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWEDWWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 18:22:46 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:12995 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751419AbWEDWWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 18:22:45 -0400
Message-ID: <445A7E68.7080109@ru.mvista.com>
Date: Fri, 05 May 2006 02:21:28 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Johan Palmqvist <johan.palmqvist@inap.se>, mlaks@verizon.net,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: hpt366 driver oops or panic with HighPoint RocketRAID	1520	SATA
 (HPT372N)
References: <436FB350.6020309@inap.se>	 <1131467876.25192.51.camel@localhost.localdomain>	 <445A5BD5.2050508@ru.mvista.com> <1146781505.24513.3.camel@localhost.localdomain>
In-Reply-To: <1146781505.24513.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:
> On Iau, 2006-05-04 at 23:53 +0400, Sergei Shtylyov wrote:
> 
>>    I think I've dealt with this oops now, see my recent patches to this
>>driver, particularly the one that reads the f_CNT value saved by BIOS...
> 
> 
> I have them queued to review in depth, although in that specific case I
> don't know if I can help - none of my cards set the BIOS provided
> value..

    Judging on a FREQ value (about 125) from the boot logs, the BIOS had set 
up PLL to 50 MHz (125/192 ~ 32/50) which should have "spoilt" the value in the 
f_CNT register. Hence, we may guess that the BIOS had saved the f_CNT value 
beforehand. If not, there's not much we can do except to guess at the DPLL 
frequence that BIOS might have set.

MBR, Sergei
