Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWGPQ1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWGPQ1A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 12:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWGPQ1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 12:27:00 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:14836 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751091AbWGPQ07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 12:26:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N6O6pPvEVgAZ3wxQInXIswfsPCM1dUDAHhzjOR+UBWroI2yNUSVrbXerolBnkcGSuqqhIu3Yxb0yUno0rhNXSttewhNbHb4ivwItCURvxMqx6VtmNpdWmjpgnblg8mWzwk1kV6tNLOU67kv1QoU8zlko3s5+vDny3DfvZLREg6I=
Message-ID: <6bffcb0e0607160926h25ae8171kf2785f731a62fb6b@mail.gmail.com>
Date: Sun, 16 Jul 2006 18:26:58 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Subject: Re: 2.6.17.3 kernel panic
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3psg5a5lp.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m3psg5a5lp.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 16/07/06, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Hi,
>
> Just got a kernel panic, it tried to print something:
>
> BUG: unable to handle kernel paging request at virtual address d47ddc68
> eip = c010b247
> *pde = 0
> (repeated throughout the screen)
>
> It's a laptop - mobile Celeron Coppermine 600 MHz, 128 MB RAM, i440BX
> - Fujitsu-Siemens Liteline Plus 419A (LF6).
> The kernel is 2.6.17.3 + Alan's IDE patch, standard config.
>
> Restarted the machine and it seems it's do_page_fault:
>
> c010ae3d T do_page_fault
> c010b368 t .text.lock.fault
[snip]
>
> What could it be?
> How could I debug it?

please try
gdb vmlinux
list *0xc010b247

> --
> Krzysztof Halasa
> -

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
