Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWFFPuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWFFPuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 11:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWFFPuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 11:50:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:19838 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751333AbWFFPui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 11:50:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uiEgV7EtHotVpSc2aqe0JaL7e1GCvr0/dJg6jXDMSXriys1cnGODwEhm4uUI+7suCUgp+y+0ULAPCt6f9vBIhyZz8Ke+xxpAt2RfR5nK/VAkSD7zSV/W9T3BdXs8jbQIlYW7mhOCtGtJgQ0Pbv9qTm/uhhuJDJcUDyTQdCDFlFo=
Message-ID: <6bffcb0e0606060850l4f8861b6je90e838b542b6fbc@mail.gmail.com>
Date: Tue, 6 Jun 2006 17:50:37 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc5 0/8] Kernel memory leak detector 0.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0606060346sb42e00apbc194cee8db3986d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060604215636.16277.15454.stgit@localhost.localdomain>
	 <6bffcb0e0606051452p26f20c8r57f2c782de691210@mail.gmail.com>
	 <b0943d9e0606060346sb42e00apbc194cee8db3986d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalian,

On 06/06/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 05/06/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > System hangs while starting udev.
> >
> > Here is config
> > http://www.stardust.webpages.pl/files/kml/kml-config
>
> I managed to reproduce the problem - the kernel can deadlock on SMP if
> the module being loaded contains the .init.memleak_aliases section.
> I'll fix it and post another patch later today.
>

I have disabled SMP and system still hangs, but now I know when :)

Here is bug http://www.stardust.webpages.pl/files/kml/bug1.jpg
Here is config http://www.stardust.webpages.pl/files/kml/kml-config2

I think that Ingo's "Ignore loglevel on printks" patch is very useful.

> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
