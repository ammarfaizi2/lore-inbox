Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbVGNXow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbVGNXow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVGNXov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:44:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19911 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262777AbVGNXou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:44:50 -0400
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
From: Daniel McNeil <daniel@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1121382983.6755.87.camel@dyn9047017102.beaverton.ibm.com>
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net>
	 <1121382983.6755.87.camel@dyn9047017102.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1121384672.6025.81.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 14 Jul 2005 16:44:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 16:16, Badari Pulavarty wrote:
> How does your patch ensures that we meet the driver alignment
> restrictions ? Like you said, you need atleast "even" byte alignment
> for IDE etc..
> 
> And also, are there any restrictions on how much the "minimum" IO
> size has to be ? I mean, can I read "1" byte ? I guess you are
> not relaxing it (yet)..
> 

This patch does not change the i/o size requirements -- they
must be a multiple of device block size (usually 512).

It only relaxes the address alignment restriction.  I do not
know what the driver alignment restrictions are.  Without the
1st patch, it was impossible to relax the address space
check and have direct-io generate the correct i/o's to submit.

This 2nd patch, is just for testing and generating feedback
to find out what the address alignment issues are.  Then
we can decide how to proceed.

Did you look over the 1st patch?  Comments?

Thanks,

Daniel
 

