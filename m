Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132479AbRDAOfC>; Sun, 1 Apr 2001 10:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132492AbRDAOew>; Sun, 1 Apr 2001 10:34:52 -0400
Received: from zeus.kernel.org ([209.10.41.242]:34248 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132479AbRDAOeo>;
	Sun, 1 Apr 2001 10:34:44 -0400
Message-ID: <3AC73AE6.9070701@optibase.com>
Date: Sun, 01 Apr 2001 16:27:50 +0200
From: Constantine Gavrilov <const-g@optibase.com>
Organization: Optibase
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac26customSMP i686; en-US; 0.8) Gecko/20010211
X-Accept-Language: en
MIME-Version: 1.0
To: Anton.Safonov@bestlinux.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA problems on IBM ThinkPad 600X
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are problems with some PCMCIA drivers included in the kernel. For 
example, support for cardbus 3com cards was moved to 3c59x.o driver. It 
works (on 600X at least) only of you compile it in. It will not work as 
a module.

I think a much better solution right now is to use drivers from 
pcmcia-cs package. It always works. If you do not configure any support 
for pcmcia in your kernel, when you build pcmcia-cs it will build kernel 
drivers from its own source tree. Just make sure you use the latest 
version. This also allows configuration files interoperbility with 2.2.x 
kernel, if you wish to use that as well.

You just need to make sure you are using "ordinary" configuration files 
if you use pcmcia-cs, since 2.4 uses different names for some of pcmcia 
drivers.  Stock pcmcia-cs package will do nicely.

-- 
----------------------------------------
Constantine Gavrilov
Linux Leader
Optibase Ltd
7 Shenkar St, Herzliya 46120, Israel
Phone: (972-9)-970-9140
Fax:   (972-9)-958-6099
----------------------------------------

