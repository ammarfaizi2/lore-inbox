Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWCURQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWCURQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWCURQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:16:49 -0500
Received: from [84.204.75.166] ([84.204.75.166]:18065 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S932291AbWCURQr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:16:47 -0500
Message-ID: <442034FE.1010006@oktetlabs.ru>
Date: Tue, 21 Mar 2006 20:16:46 +0300
From: "Artem B. Bityutskiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/23] Kobject: provide better warning messages when people
 do stupid things
References: <11428920383371-git-send-email-gregkh@suse.de>
In-Reply-To: <11428920383371-git-send-email-gregkh@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote:
> +
> +		/* be noisy on error issues */
> +		if (error == -EEXIST)
> +			printk("kobject_add failed for %s with -EEXIST, "
> +			       "don't try to register things with the "
> +			       "same name in the same directory.\n",
> +			       kobject_name(kobj));

This looks like an attempt to put documentation into kernel code. Isn't 
  it better to add good documentation to the header file just above the 
prototype?

When I started using sysfs, I noticed a lack of good comments above 
prototypes of exported functions.

-- 
Best regards, Artem B. Bityutskiy
Oktet Labs (St. Petersburg), Software Engineer.
+7 812 4286709 (office) +7 911 2449030 (mobile)
E-mail: dedekind@oktetlabs.ru, Web: www.oktetlabs.ru
