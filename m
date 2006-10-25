Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161371AbWJYUlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161371AbWJYUlh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161380AbWJYUlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:41:37 -0400
Received: from smtpout.mac.com ([17.250.248.175]:32993 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161371AbWJYUlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:41:36 -0400
In-Reply-To: <1161808227.7615.0.camel@localhost.localdomain>
References: <1161807069.3441.33.camel@dv> <1161808227.7615.0.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B929A767-F186-4281-BF32-132534D3FB56@mac.com>
Cc: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: incorrect taint of ndiswrapper
Date: Wed, 25 Oct 2006 16:40:30 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 25, 2006, at 16:30:26, Alan Cox wrote:
> Ar Mer, 2006-10-25 am 16:11 -0400, ysgrifennodd Pavel Roskin:
>> I don't see any legal reasons behind this restriction.  A driver  
>> under GPL should be able to use any exported symbols.   
>> EXPORT_SYMBOL_GPL is a technical mechanism of enforcing GPL  
>> against non-free code, but ndiswrapper is free.  The non-free NDIS  
>> drivers are not using those symbols.
>
> The combination of GPL wrapper and the NDIS driver as a work is not  
> free (in fact its questionable if its even legal to ship such a  
> combination together).

Assume the existence of two programs, Foo and Bar (ndiswrapper and  
vendor-NDIS-driver).  If Foo and Bar are different licenses (GPL vs  
proprietary) it is not legal to distribute them as part of a single  
work unless you convince the copyright owners to relicense.  It _is_  
however, perfectly legal for an end user to download Foo from  
www.foo.com and Bar from www.bar.com and combine the two on his  
computer, whether or not that does anything useful.  Since the  
ndiswrapper driver was not based on any particular driver but on a  
defined standard, using ndiswrapper with a proprietary NDIS driver is  
just as legal as using a proprietary database server on a GPLed Linux  
system.  The technical issues of which ring the code runs in is  
irrelevant as long as the user obtained both pieces separately and  
neither is a derivative work of the other.

Besides, if the user does not distribute it then copyright law is  
irrelevant.

Cheers,
Kyle Moffett
