Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbTF3PKC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 11:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbTF3PKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 11:10:02 -0400
Received: from dm5-224.slc.aros.net ([66.219.220.224]:32129 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264898AbTF3PKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 11:10:00 -0400
Message-ID: <3F005621.1060708@aros.net>
Date: Mon, 30 Jun 2003 09:24:17 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.73-mm1 nbd: boot hang in add_disk at first call from nbd_init
References: <200306271943.13297.mflt1@micrologica.com.hk>
In-Reply-To: <200306271943.13297.mflt1@micrologica.com.hk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank wrote:

>Changes were recently made to the nbd.c in 2.5.73-mm1
>
>When using nbd.c ex 2.5.73 boot OK. 
>acpi=off no effect
>
>----------------------------
>dmesg using nbd.c ex 2.5.73:
>
>loop: loaded (max 8 devices)
>anticipatory scheduling elevator
>
>(Using nbd.c ex 2.5.73-mm1
> nbd: registered device at major 43
>  hang) . . .
>
Thank you for reporting this. A few others have also found this same 
problem and a patch that fixes this has been submitted to Andrew. I 
haven't had the chance yet to figure out what release of mm this fix may 
have made it into. The reason for this problem in the first place was 
that the patch which caused the problem was tested against 2.5.73 then 
applied into Andrew's 2.5.73-mm1 release. Some other changes that made 
it into 2.5.73-mm1 (in a non-nbd system that also hadn't been in 2.5.73 
yet) interacted with the nbd change in the un-expected way you've seen. 
If there are still problems you can track back to nbd please let me know.

