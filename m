Return-Path: <linux-kernel-owner+w=401wt.eu-S932439AbXAGJEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbXAGJEH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 04:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbXAGJEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 04:04:06 -0500
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:51235 "EHLO
	smtpq3.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439AbXAGJED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 04:04:03 -0500
Message-ID: <45A0B71F.1080704@gmail.com>
Date: Sun, 07 Jan 2007 10:02:23 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] romsignature/checksum cleanup
References: <458EEDF7.4000200@gmail.com>  <458F20FB.7040900@gmail.com> <1167179512.16175.4.camel@localhost.localdomain> <459310A3.4060706@vmware.com> <459ABA2F.6070907@gmail.com> <459EDDD1.6060208@goop.org> <459F1B82.6000808@gmail.com> <45A0B660.4060505@goop.org>
In-Reply-To: <45A0B660.4060505@goop.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2007 09:59 AM, Jeremy Fitzhardinge wrote:

> Rene Herman wrote:

>> In your opinion, is the attached (versus 2.6.20-rc3) better? This
>> uses probe_kernel_address() for all accesses. Or rather, an
>> expanded version thereof. The set_fs() and
>> pagefault_{disable,enable} calls are only done once in
>> probe_roms().
> 
> I don't think this is worthwhile.  Its hardly a performance-critical 
> piece of code, and I think its better to use the straightforward 
> interface rather than complicating it for some nominal extra
> efficiency.

How is it for efficiency? I thought it was for correctness. romsignature 
is using probe_kernel_adress() while all other accesses to the ROMs 
there aren't.

If nothing else, anyone reading that code is likely to ask himself the 
very same question -- why the one, and not the others.

Rene.

