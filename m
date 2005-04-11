Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVDKNJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVDKNJt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 09:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDKNJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 09:09:49 -0400
Received: from hermes.domdv.de ([193.102.202.1]:54534 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261582AbVDKNJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 09:09:35 -0400
Message-ID: <425A770C.7050208@domdv.de>
Date: Mon, 11 Apr 2005 15:09:32 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Oops in swsusp
References: <4259B425.4090105@domdv.de> <200504110859.00961.rjw@sisk.pl>
In-Reply-To: <200504110859.00961.rjw@sisk.pl>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 11 of April 2005 01:17, Andreas Steinmetz wrote:
> 
>>Pavel,
>>during testing of the encrypted swsusp_image on x86_64 I did get an Oops
>>from time to time at memcpy+11 called from swsusp_save+1090 which turns
>>out to be the memcpy in copy_data_pages() of swsusp.c.
>>The Oops is caused by a NULL pointer (I don't remember if it was source
>>or destination).
> 
> 
> It's quite important, however.  If it's the destination, it's probably a bug in
> swsusp.  Otherwise, the problem is more serious.  Could you, please,
> add BUG_ON(!pbe->address) right before the memcpy() and retest?

I'll try.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
