Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVDLKH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVDLKH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVDLKH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:07:27 -0400
Received: from hermes.domdv.de ([193.102.202.1]:2065 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262094AbVDLKHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:07:02 -0400
Message-ID: <425B9DC4.8040002@domdv.de>
Date: Tue, 12 Apr 2005 12:07:00 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <4259B474.4040407@domdv.de> <200504112257.39708.rjw@sisk.pl> <20050411210819.GF23530@elf.ucw.cz> <200504112335.39155.rjw@sisk.pl>
In-Reply-To: <200504112335.39155.rjw@sisk.pl>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 11 of April 2005 23:08, Pavel Machek wrote:
> 
>>Hi!
>>
> 
> ]--snip--[
> 
>>>>@@ -130,6 +150,52 @@
>>>> static unsigned short swapfile_used[MAX_SWAPFILES];
>>>> static unsigned short root_swap;
>>>> 
>>>>+#ifdef CONFIG_SWSUSP_ENCRYPT
>>>>+static struct crypto_tfm *crypto_init(int mode)
>>>
>>>I think it's better if this function returns an int error code and the
>>>messages are printed where it's called from.  This way, the essential
>>>part of the code would be easier to grasp (Pavel?).
>>
>>Agreed. Actually I do not care where messages are printed, but
>>returning different code for different errors seems right.
> 
> 
> Hm.  You probably don't want suspend-related messages to be printed during
> resume (this function is called in two different places)? :-)
> 
> Rafael
> 
> 

Will be changed.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
