Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131733AbRDYUkt>; Wed, 25 Apr 2001 16:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDYUkk>; Wed, 25 Apr 2001 16:40:40 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:46035 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S131733AbRDYUk2>; Wed, 25 Apr 2001 16:40:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
Date: Wed, 25 Apr 2001 22:40:49 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <200104251937.OAA27702@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200104251937.OAA27702@tomcat.admin.navo.hpc.mil>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01042522404901.00954@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 April 2001 21:37, you wrote:
> Personally, I think
>> 	proc_printf(fragment, "%d %d",get_portnum(usbdev), usbdev->maxchild);
> is shorter (and faster) to parse with
> 	fscanf(input,"%d %d",&usbdev,&maxchild);

Right, but what happens if you need to extend the format? For example 
somebody adds support for USB 2.0 to the kernel and you need to some new 
values. Then you would have the choice between changing the format and 
breaking applications or keeping the format and dont provide the additional 
information. 
With XML (or single-value-per-file) it is easy to tell application to ignore 
unknown tags (or files). When you just list values you will be damned sooner 
or later, unless you make up additional rules that say how apps should handle 
these cases. And then your approach is no longer simple, but possibly even 
more complicated

bye... 
