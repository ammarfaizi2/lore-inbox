Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423682AbWJaRNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423682AbWJaRNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423692AbWJaRNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:13:33 -0500
Received: from smtp-out.google.com ([216.239.45.12]:33106 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1423682AbWJaRNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:13:32 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=w7YU37NWRj6hRTAshIggeYgrpF3yvgL9wFNDDuGYAe4rtlFU5EjYcD8SthnZEutJy
	VsDJwiY4vdVMELKGx+Wdw==
Message-ID: <4547833C.5040302@google.com>
Date: Tue, 31 Oct 2006 09:09:16 -0800
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Cornelia Huck <cornelia.huck@de.ibm.com>
CC: Greg KH <gregkh@suse.de>, Mike Galbraith <efault@gmx.de>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
References: <45461977.3020201@shadowen.org>	<45461E74.1040408@google.com>	<20061030084722.ea834a08.akpm@osdl.org>	<454631C1.5010003@google.com>	<45463481.80601@shadowen.org>	<20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>	<1162276206.5959.9.camel@Homer.simpson.net>	<4546EF3B.1090503@google.com>	<20061031065912.GA13465@suse.de>	<4546FB79.1060607@google.com>	<20061031075825.GA8913@suse.de>	<45477131.4070501@google.com> <20061031174639.4d4d20e3@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061031174639.4d4d20e3@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cornelia Huck wrote:
> On Tue, 31 Oct 2006 07:52:17 -0800,
> "Martin J. Bligh" <mbligh@google.com> wrote:
> 
>>>>> Merely change CONFIG_SYSFS_DEPRECATED to be set to yes, and it should
>>>>> all work just fine.  Doesn't anyone read the Kconfig help entries for
>>>>> new kernel options?
>>>> 1. This doesn't fix it.
>>> I think acpi is now being fingered here, right?
>> Eh? How. Backing out all your patches from -mm fixes it.
>> The deprecated stuff does not fix it, it's the same as before.
> 
> That's because /sys/class/net/<interface> is now a symlink instead of a
> directory (and that hasn't anything to do with acpi, but rather with
> the conversions in the driver tree). Seems the directory -> symlink
> change shouldn't be done since it's impacting user space...

You know which individual patch in -mm broke that? Can't see it easily.
Then we can just test across all the machines with just that one backed
out.

Thanks,

M.

