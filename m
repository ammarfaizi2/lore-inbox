Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbVIASTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbVIASTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbVIASTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:19:49 -0400
Received: from [85.8.12.41] ([85.8.12.41]:45209 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1030280AbVIASTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:19:49 -0400
Message-ID: <43174643.7040007@drzeus.cx>
Date: Thu, 01 Sep 2005 20:19:47 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: ncunningham@cyclades.com, Pavel Machek <pavel@ucw.cz>,
       Meelis Roos <mroos@linux.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: reboot vs poweroff
References: <20050901062406.EBA5613D5B@rhn.tartu-labor>	<1125557333.12996.76.camel@localhost>	<Pine.SOC.4.61.0509011030430.3232@math.ut.ee>	<4316F4E3.4030302@drzeus.cx> <1125578897.4785.23.camel@localhost>	<m1fysoq0p7.fsf@ebiederm.dsl.xmission.com> <43171C02.30402@drzeus.cx> <m1aciwpvsz.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1aciwpvsz.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>Thanks.
>
>This is clearly a code path I missed when I was fixing things.
>
>When I made the final acpi change I checked for any other users
>of device_suspend and it seems I was blind and missed this one.
>Looking again...
>
>The patch in the bug report looks correct.  However it is still
>a little incomplete.  In particular the reboot notifier is not
>being called, and since not everything has been converted into
>using shutdown methods that could lead to some other inconsistent
>behavior.
>
>Does anyone have any problems with the patch below?
>If not I will send this off to Linus..
>
>  
>

Patch tested and works fine here. You should probably make a note in the
bugzilla so we don't get a conflicting merge from the ACPI folks.

I suppose Nigel should use this function in swsusp2 aswell?

Rgds
Pierre

