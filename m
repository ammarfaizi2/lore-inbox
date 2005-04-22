Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVDVQFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVDVQFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 12:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVDVQFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 12:05:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:18582 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262046AbVDVQEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 12:04:21 -0400
Message-ID: <42691498.7060003@suse.de>
Date: Fri, 22 Apr 2005 17:13:28 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@sisk.pl, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Steinmetz <ast@domdv.de>
Subject: Re: Linux 2.6.12-rc3: various swsusp problems
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <4267DC2E.9030102@domdv.de> <20050421185717.GB475@openzaurus.ucw.cz>
In-Reply-To: <20050421185717.GB475@openzaurus.ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------050405030601080501000004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050405030601080501000004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Pavel Machek wrote:
>> 1. Is it necessary to print the following message during regular boot?
>>    swsusp: Suspend partition has wrong signature?

> Hmm, feel free to provide a patch. (I need something to try git on :-).

Attached (sorry, Thunderbird...). One may argue over KERN_ERR, but i
don't mind.
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."

--------------050405030601080501000004
Content-Type: text/plain;
 name="delme"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="delme"

--- linux/kernel/power/swsusp.c~	2005-04-22 17:07:56.000000000 +0200
+++ linux/kernel/power/swsusp.c	2005-04-22 17:09:22.000000000 +0200
@@ -1239,7 +1239,7 @@ static int check_sig(void)
 		 */
 		error = bio_write_page(0, &swsusp_header);
 	} else { 
-		printk(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
+		printk(KERN_ERR "swsusp: Suspend partition is no suspend image.\n");
 		return -EINVAL;
 	}
 	if (!error)

--------------050405030601080501000004--

