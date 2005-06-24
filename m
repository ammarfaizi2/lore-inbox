Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbVFXXHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVFXXHX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 19:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbVFXXHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 19:07:22 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:47378 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S262675AbVFXXHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 19:07:12 -0400
Message-ID: <42BC93EC.8030909@shadowconnect.com>
Date: Sat, 25 Jun 2005 01:14:52 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] I2O: Lindent run and replacement of printk through osm
 printing functions
References: <200506241709.j5OH98vv000983@hera.kernel.org> <42BC888E.3010600@pobox.com>
In-Reply-To: <42BC888E.3010600@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
>> tree da7e51e7204625f21371eac23a931f4fe479e9db
>> parent 9e87545f06930c1d294423a8091d1077e7444a47
>> author Markus Lidel <Markus.Lidel@shadowconnect.com> Fri, 24 Jun 2005 
>> 12:02:23 -0700
>> committer Linus Torvalds <torvalds@ppc970.osdl.org> Fri, 24 Jun 2005 
>> 14:05:29 -0700
>> [PATCH] I2O: Lindent run and replacement of printk through osm 
>> printing functions
>> Lindent run and replaced printk() through the corresponding osm_*() 
>> function
> Please don't combine ANY code changes with an Lindent patch.

Also if there is no functional change, only cosmetical (the osm_*() 
function just mappes to printk(*, ...))?

> Also, you typically want to do a pass through the post-Lindent code, to 
> fix crazy word-wrapped lines like
>>                  if (copy_from_user
>> -                    (p->virt, (void __user *)(unsigned 
>> long)sg[i].addr_bus,
>> -                     sg_size)) {
>> +                    (p->virt,
>> +                     (void __user *)(unsigned long)sg[i].
>> +                     addr_bus, sg_size)) {
>>                      printk(KERN_DEBUG
>>                             "%s: Could not copy SG buf %d FROM user\n",
>>                             c->name, i);

OK, next time i do this too (i've not touched it, because i only have a 
80x24 terminal and  it was more readable after the Lindent run for me :-D)...

Thank you very much!


Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
