Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWEaPFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWEaPFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 11:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWEaPFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 11:05:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:62181 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965060AbWEaPFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 11:05:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gtbmRKCu0N/4E7LKDyX6+iKofqEvzmtrkJmu3uWXVtRzcW3edvL8iQzKO51RZSW+OyEU9cHoRvNMsjopGHSQKtXgjZNBLCfqR3QIFnERC0iWhOkHzDGnEYJBAG5vMeVTrZdqWMRhh2eHoL3LknXpm9epcljOMTWN195I8BWOm1g=
Message-ID: <6bffcb0e0605310805l5e040e06i8ccc376a88667c34@mail.gmail.com>
Date: Wed, 31 May 2006 17:05:21 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm1
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060531141208.GA12296@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com>
	 <6bffcb0e0605310651u61b9756fpfce3515ab046bf42@mail.gmail.com>
	 <20060531140201.GA11617@elte.hu> <20060531141208.GA12296@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
> > i think what happened is that the pagefault happened with irqs
> > disabled, and the entry.S return-to-exception-site irq-flags tracing
> > code mistakenly turned on the irq flag - causing the mismatch and
> > lockdep's confusion.
>
> here's the fix for the irqs-off iret irqflags-tracing problem. Does this
> fix the bug(s) on your box?

Yes. Thanks!

>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
