Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVDMLtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVDMLtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVDMLtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:49:20 -0400
Received: from indonesia.procaptura.com ([193.214.130.21]:12191 "EHLO
	indonesia.procaptura.com") by vger.kernel.org with ESMTP
	id S261306AbVDMLtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:49:15 -0400
Message-ID: <425D0736.1080105@procaptura.com>
Date: Wed, 13 Apr 2005 13:49:10 +0200
From: Toralf Lund <toralf@procaptura.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: insmod segfault in pci_find_subsys()
References: <423A9B65.1020103@procaptura.com>	 <20050318170709.GD14952@kroah.com> <42496309.3080007@procaptura.com>	 <20050413071233.GB25581@kroah.com>  <425CFBDA.9040301@procaptura.com> <1113390818.6275.52.camel@laptopd505.fenrus.org>
In-Reply-To: <1113390818.6275.52.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>Yes. You are right. I actually mentioned this on a different thread: I 
>>eventually found out that the kernel was compiled with -mregparam=3, and 
>>the module was not. This option seems to have been added to the default 
>>config and/or Red Hat's build setup sometime before the current kernel 
>>release, but after the start of the 2.6 series...
>>    
>>
>
>that means your makefile indeed is utterly bust. A correct makefile for
>an external module correctly and automatically inherits all the CFLAGs
>used by the kernel.
>  
>
Yes. As I've (also) already said elsewhere, I knew that, really. The 
current build setup fails to do this partly for historical reasons, 
partly because the driver also supports different OSes. (And is still 
expected to build correctly with Linux 2.4, not just 2.6.)

>Care to point to a full URL of your module so that we can help you by
>sending patches?
>
Official (info page) URL is http://itifg.sourceforge.net/

The most recent source is probably 
ftp://ftp.gom.com/pub/ITI-FG/itifg-8.2.1-11.tar.gz.


>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


