Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVGKSgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVGKSgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVGKSd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:33:59 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:56471 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261393AbVGKScK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:32:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kER2uLrGm3MMfrLElqDuu3mNZyuWMGHK/ee1uF1fyiGvX1wKepTNg57AbDd+8h/RBhYmHssEGF7WDy3GOZQm2a1s1u/yyG6WXP7MEINZ7zHWbj6j1qHg2/zeA7Mx9Jlikr3OFMHrirzMcUbfq91SCroG8YSL82FPGj3iIbBxzj8=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Tom Duffy <Tom.Duffy@sun.com>
Subject: Re: [openib-general] Re: [PATCH 3/27] Add MAD helper functions
Date: Mon, 11 Jul 2005 22:38:27 +0400
User-Agent: KMail/1.8.1
Cc: Hal Rosenstock <halr@voltaire.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
References: <1121089079.4389.4511.camel@hal.voltaire.com> <200507111839.41807.adobriyan@gmail.com> <42D2B1F1.7000408@sun.com>
In-Reply-To: <42D2B1F1.7000408@sun.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507112238.27856.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 July 2005 21:52, Tom Duffy wrote:
> Alexey Dobriyan wrote:
> 
> >unsigned int __nocast gfp_mask, please. 430 or so infiniband sparse warnings
> >is not a reason to add more.
> >  
> >
> Can you please elaborate on the sparse warnings that you are seeing 
> throughout the rest of infiniband?

$ make allmodconfig >/dev/null
$ make C=2 CHECK="sparse -Wbitwise" drivers/infiniband/ 2>&1 | tee ../W_infiniband
	[snip]
$ grep -c "warning: " ../W_infiniband
430
