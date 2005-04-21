Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVDUNlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVDUNlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 09:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVDUNlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 09:41:00 -0400
Received: from ns1.coraid.com ([65.14.39.133]:45750 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261374AbVDUNky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 09:40:54 -0400
To: 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.12-rc2] aoe [1/6]: improve allowed interfaces 
 configuration
References: <3VqSf-2z7-15@gated-at.bofh.it>
	<E1DOVtj-0003bF-6c@be1.7eggert.dyndns.org>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 21 Apr 2005 09:36:17 -0400
In-Reply-To: <E1DOVtj-0003bF-6c@be1.7eggert.dyndns.org> (Bodo Eggert's
 message of "Thu, 21 Apr 2005 09:14:46 +0200")
Message-ID: <87y8bcjlpq.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" <7eggert@gmx.de> writes:

> Ed L Cashin <ecashin@coraid.com> wrote:
>
>> +++ b/Documentation/aoe/aoe.txt       2005-04-20 11:42:20.000000000 -0400
>
>> +  When the aoe driver is a module, use
>
> Is there any reason for this inconsistent behaviour?

Yes, the /sys/module/aoe area is only present when the aoe driver is a
module.  It would be nicer if there were a sysfs area where I could
put this file regardless of whether the driver is a module or built
into the kernel.  

I could probably create one, but I got the file in
/sys/module/aoe/parameters for free when I used module_param_string.

>> +  /sys/module/aoe/parameters/aoe_iflist instead of
>                                 ^^^
>
> Why does the module name need to be part of the attribute?
> That's redundant. That's redundant.

Yes.  That's true.  Redundancy isn't always bad, though, and using the
"aoe_" prefix lets the kernel parameter for the built-in aoe driver be
the same as the parameter for the modular driver.

-- 
  Ed L Cashin <ecashin@coraid.com>

