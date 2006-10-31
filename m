Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423505AbWJaPz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423505AbWJaPz5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423511AbWJaPz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:55:57 -0500
Received: from smtp-out.google.com ([216.239.45.12]:41279 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1423505AbWJaPz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:55:56 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=Wk3CN6MYSOoEN5+d0V3OlsS++ZCAHsn7jkRxizrVu7D0MIMjyg1gHmTIFawd4VfTw
	iuqQmyWOQ2xz6KM36ZrQA==
Message-ID: <45477131.4070501@google.com>
Date: Tue, 31 Oct 2006 07:52:17 -0800
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Mike Galbraith <efault@gmx.de>, Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
References: <45461977.3020201@shadowen.org> <45461E74.1040408@google.com> <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com> <45463481.80601@shadowen.org> <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com> <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com> <20061031065912.GA13465@suse.de> <4546FB79.1060607@google.com> <20061031075825.GA8913@suse.de>
In-Reply-To: <20061031075825.GA8913@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Merely change CONFIG_SYSFS_DEPRECATED to be set to yes, and it should
>>> all work just fine.  Doesn't anyone read the Kconfig help entries for
>>> new kernel options?
>> 1. This doesn't fix it.
> 
> I think acpi is now being fingered here, right?

Eh? How. Backing out all your patches from -mm fixes it.
The deprecated stuff does not fix it, it's the same as before.

Unless it's some strange interaction between driver-core/sysfs and ACPI,
I don't see how it can be ACPI's fault?

>> 2. Breaking things by default with an option to unbreak them is not
>> the finest of plans ;-)
> 
> Yes, I have now changed the default for that option to be on to help
> guide people even better than before.

There's still some other problem there though. See:

http://test.kernel.org/abat/59232/debug/console.log

who's config is here:

http://test.kernel.org/abat/59232/build/dotconfig

A working log from that machine is here:

http://test.kernel.org/abat/59306/debug/console.log

M.
