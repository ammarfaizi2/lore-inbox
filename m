Return-Path: <linux-kernel-owner+w=401wt.eu-S1753620AbXABUDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbXABUDX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754850AbXABUDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:03:23 -0500
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:34565 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbXABUDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:03:22 -0500
Message-ID: <459ABA2F.6070907@gmail.com>
Date: Tue, 02 Jan 2007 21:01:51 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] romsignature/checksum cleanup
References: <458EEDF7.4000200@gmail.com>  <458F20FB.7040900@gmail.com> <1167179512.16175.4.camel@localhost.localdomain> <459310A3.4060706@vmware.com>
In-Reply-To: <459310A3.4060706@vmware.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:

>> Rusty Russell wrote:
>> 
>>> Rene Herman wrote:
>>> 
>>> Hmm, by the way, if romsignature() needs this
>>> probe_kernel_address() thing, why doesn't romchecksum()?
>> 
>> I assume it's all in the same page, but CC'ing Zach is easier than 
>> reading the code 8)
>> 
> 
> Some hypervisors don't emulate the traditional physical layout of the
> first 1M of memory, so those pages might never get physical mappings
> established during the boot process, causing access to them to
> fault. Presumably, if the first page is there with a good signature,
> the entire ROM is mapped.  I think Jeremy added this for Xen, and
> it's harmless on native hardware.

Jeremy? Is it okay to only check the signature word? The checksum will 
generally be done over more than 1 (hw) page... That "presumably" there 
seems a bit flaky?

Rene.
