Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVGZOo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVGZOo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 10:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVGZOo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:44:28 -0400
Received: from relay01.pair.com ([209.68.5.15]:24848 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261817AbVGZOo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:44:27 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42E64C43.2050104@cybsft.com>
Date: Tue, 26 Jul 2005 09:44:19 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 PREEMPT_RT && PPC
References: <200507200816.11386.kernel@kolivas.org> <20050719223216.GA4194@elte.hu> <1121819037.26927.75.camel@dhcp153.mvista.com> <200507201104.48249.kernel@kolivas.org> <1121822524.26927.85.camel@dhcp153.mvista.com> <42DF293A.4050702@timesys.com> <20050726120015.GB9224@elte.hu>
In-Reply-To: <20050726120015.GB9224@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010002080600020306010206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010002080600020306010206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * john cooper <john.cooper@timesys.com> wrote:
> 
> 
>>Ingo,
>>    Attached is a patch for 51-28 which brings PPC up to date for 
>>2.6.12 PREEMPT_RT.  My goal was to get a more recent vintage of this 
>>work building and minimally booting for PPC.  Yet this has been stable 
>>even under our internal stress tests.  We now have this running on 
>>8560 and 8260 PPC targets with a few others in the pipe.
> 
> 
> great. I've applied most of your patch and have released the -51-37 
> kernel. A couple of generic bits i did not apply.
> 
> 
<snip>

On X86 -51-36 won't build with CONFIG_BLOCKER=Y without the attached patch.


-- 
    kr

--------------010002080600020306010206
Content-Type: text/x-patch;
 name="blocker.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blocker.patch"

--- linux-2.6.12/drivers/char/blocker.c.orig	2005-07-26 09:32:28.000000000 -0500
+++ linux-2.6.12/drivers/char/blocker.c	2005-07-26 09:32:33.000000000 -0500
@@ -4,7 +4,6 @@
 
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
-#include <asm/time.h>
 
 #define BLOCKER_MINOR		221
 

--------------010002080600020306010206--
