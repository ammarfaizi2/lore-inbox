Return-Path: <linux-kernel-owner+w=401wt.eu-S932871AbWL0ArD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871AbWL0ArD (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 19:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932872AbWL0ArD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 19:47:03 -0500
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:50021 "EHLO
	smtpq3.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932871AbWL0ArB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 19:47:01 -0500
Message-ID: <4591C230.3070705@gmail.com>
Date: Wed, 27 Dec 2006 01:45:36 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] romsignature/checksum cleanup
References: <458EEDF7.4000200@gmail.com>  <458F20FB.7040900@gmail.com> <1167179512.16175.4.camel@localhost.localdomain>
In-Reply-To: <1167179512.16175.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> On Mon, 2006-12-25 at 01:53 +0100, Rene Herman wrote:

>> Hmm, by the way, if romsignature() needs this probe_kernel_address() 
>> thing, why doesn't romchecksum()?
> 
> I assume it's all in the same page, but CC'ing Zach is easier than
> reading the code 8)

If we're talking hardware pages here; the romchecksum() might be done 
over an area upto 0xff x 512 = 130560 bytes (there's also an acces to 
the length byte at rom[2] in probe_roms(). I assume that one's okay if 
romsignature() ensured that the first page is in).

Rene.

