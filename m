Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSJQMDX>; Thu, 17 Oct 2002 08:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSJQMDS>; Thu, 17 Oct 2002 08:03:18 -0400
Received: from hermes.domdv.de ([193.102.202.1]:52229 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S261411AbSJQLgR>;
	Thu, 17 Oct 2002 07:36:17 -0400
Message-ID: <3DAEA20B.6040501@domdv.de>
Date: Thu, 17 Oct 2002 13:42:03 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
CC: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.5.42: remove capable(CAP_SYS_RAWIO) check from
 open_kmem
References: <3DA985E6.6090302@colorfullife.com>	<87adliuyp6.fsf@goat.bogus.local> <3DA99A8B.5050102@colorfullife.com>	<873crauw1m.fsf@goat.bogus.local> <3DA9A796.4070600@colorfullife.com> <87y992805n.fsf@goat.bogus.local>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>What about writing a small wrapper application that drops all
>>priveleges except CAP_RAWIO, switches to user to the user you want,
>>then execs the target application that needs to access /dev/kmem?
> 
> 
> I just tried this, but I didn't succeed. :-(
> 
> 
>>Or store the capabilities in the filesystem, but I don't know which
>>filesystem supports that.
> 
> 
> There's none so far.
> 

Not exactly. Well, not really a filesystem. But there's already security 
use of this feature you want to remove. Think LSM. Look at e.g. LIDS. Im 
using this additional protection already under 2.4.x to prevent uid 0 
processes to access /dev/mem and /dev/kmem where not explicitely 
granted. Please, _don't_ remove the capability check because you don't 
see any use for it as there _is_ already use for it.

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

