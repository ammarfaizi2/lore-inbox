Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbWDNHew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWDNHew (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 03:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWDNHew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 03:34:52 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:47881 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965116AbWDNHev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 03:34:51 -0400
Message-ID: <443F5245.9000400@sw.ru>
Date: Fri, 14 Apr 2006 11:41:57 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: devel@openvz.org
CC: Cedric Le Goater <clg@fr.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       Kir Kolyshkin <kir@sacred.ru>, Sam Vilain <sam@vilain.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143588501.6325.75.camel@localhost.localdomain>	<442A4FAA.4010505@openvz.org>	<20060329134524.GA14522@MAIL.13thfloor.at> <442A9E1E.4030707@sw.ru>	<1143668273.9969.19.camel@localhost.localdomain>	<443CBA48.7020301@sw.ru> <20060413010506.GA16864@MAIL.13thfloor.at>	<443DF523.3060906@openvz.org>	<20060413134239.GA6663@MAIL.13thfloor.at>	<443EC399.2040307@fr.ibm.com> <20060413224533.GA11178@MAIL.13thfloor.at>
In-Reply-To: <20060413224533.GA11178@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would be really interested in getting comparisons
> between vanilla kernels and linux-vserver patched
> versions, especially vs2.1.1 and vs2.0.2 on the
> same test setup with a minimum difference in config
> 
> I doubt that you can really compare across the
> existing virtualization technologies, as it really
> depends on the setup and hardware 
and kernel .config's :)
for example, I'm pretty sure, OVZ smp kernel is not the same as any of 
prebuilt vserver kernels.

> In my experience it is extremely hard to do 'proper'
> comparisons, because the slightest change of the
> environment can cause big differences ...
> 
> here as example, a kernel build (-j99) on 2.6.16
> on a test host, with and without a chroot:
> 
> without:
> 
>  451.03user 26.27system 2:00.38elapsed 396%CPU
>  449.39user 26.21system 1:59.95elapsed 396%CPU
>  447.40user 25.86system 1:59.79elapsed 395%CPU
> 
> now with:
> 
>  490.77user 24.45system 2:13.35elapsed 386%CPU
>  489.69user 24.50system 2:12.60elapsed 387%CPU
>  490.41user 24.99system 2:12.22elapsed 389%CPU
> 
> now is chroot() that imperformant? no, but the change
> in /tmp being on a partition vs. tmpfs makes quite
> some difference here
filesystem performance also very much depends on disk layout.
If you use different partitions of the same disk for Xen, vserver and OVZ,
one of them will be quickest while others can be significantly slower 
and slower :/

Thanks,
Kirill

