Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUCDMey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 07:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUCDMey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 07:34:54 -0500
Received: from [195.23.16.24] ([195.23.16.24]:45732 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261866AbUCDMew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 07:34:52 -0500
Message-ID: <4047221E.9050500@grupopie.com>
Date: Thu, 04 Mar 2004 12:33:34 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg KH <greg@kroah.com>, Andy Lutomirski <luto@myrealbox.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BUG] usblp_write spins forever after an	error
References: <402FEAD4.8020602@myrealbox.com>	 <20040216035834.GA4089@kroah.com>  <4030DEC5.2060609@grupopie.com> <1078399532.4619.129.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

> On Mon, 2004-02-16 at 15:16 +0000, Paulo Marques wrote:
> 
>>This patch corrected a problem for me, that happened when a printer presents an 
>>out-of-paper status while printing a document. The driver would send endless 
>>garbage to the printer.
>>
> 
> This patch went in to 2.6.4-rc1, didn't it? It seems to have exacerbated
> a problem which used to be occasional, but now seems to happen after
> every print job.
> 
> I see the following, and the error repeats until I power cycle the
> printer (HPLJ 1200 on AMD768 OHCI):
> 
> usb 1-1.3.2: control timeout on ep0in
> drivers/usb/class/usblp.c: usblp0: error -110 reading printer status
> 


Yes, unfortunately it did went into 2.6.4-rc1. However it is already corrected 
in 2.6.4-rc2. Luckily it didn't went into any "non-rc" official release.

Please try 2.6.4-rc2, and check to see if the bug went away...

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

