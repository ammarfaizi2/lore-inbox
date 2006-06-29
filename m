Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbWF2XWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbWF2XWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933091AbWF2XWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:22:37 -0400
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:6106 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932646AbWF2XWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:22:36 -0400
Message-ID: <44A46130.8090102@keyaccess.nl>
Date: Fri, 30 Jun 2006 01:24:32 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Gregoire Favre <gregoire.favre@gmail.com>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@codemonkey.org.uk>, Gerd Hoffmann <kraxel@suse.de>
Subject: Re: 2.6.17-mm4 undefined reference to `alternatives_smp_module_del'
References: <20060629122721.GA18671@gmail.com> <20060629154247.1bf8eccf.akpm@osdl.org>
In-Reply-To: <20060629154247.1bf8eccf.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> <looks at davej>
> 
> That patch is pretty yuk anyway
> 
>  void module_arch_cleanup(struct module *mod)
>  {
> +#ifdef CONFIG_SMP
> 	alternatives_smp_module_del(mod);
> +#endif
>  }
> 
> Should be a stub in a header file, which would fix this problem too.

Gerd Hoffmann already did this and I suppose it's in some upstream tree 
somewhere:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114743413932319&w=2

Rene.

