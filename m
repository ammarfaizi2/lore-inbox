Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVBYPtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVBYPtP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVBYPtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:49:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62155 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262729AbVBYPsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:48:42 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16927.18664.299731.615826@segfault.boston.redhat.com>
Date: Fri, 25 Feb 2005 10:48:56 -0500
To: "shabanip" <shabanip@avapajoohesh.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to capture kernel panics
In-Reply-To: <56349.69.93.110.242.1109346680.squirrel@69.93.110.242>
References: <52765.69.93.110.242.1109288148.squirrel@69.93.110.242>
	<200502251517.56254.linux-kernel@borntraeger.net>
	<16927.14697.76256.482062@segfault.boston.redhat.com>
	<53739.69.93.110.242.1109344057.squirrel@69.93.110.242>
	<16927.17446.834879.371263@segfault.boston.redhat.com>
	<56349.69.93.110.242.1109346680.squirrel@69.93.110.242>
X-Mailer: VM 7.19 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: how to capture kernel panics; "shabanip" <shabanip@avapajoohesh.com> adds:

shabanip> thanks for the help.  does anything else left to configure?

On the log target system, you will probably want to run something similar
to netcat to capture the logs.  To simply output to a terminal, you could
do something like this:

nc -l -p 6666 -u

-Jeff

shabanip> Payam Shabanian shabanip -at- avapajoohesh.com


>> ==> Regarding Re: how to capture kernel panics; "shabanip"
>> <shabanip@avapajoohesh.com> adds:
>> 
shabanip> as i see netconsole is a kernel module.  so i just need to load
shabanip> netconsole module with server:port parameters.  am i right?
>> MODULE_PARM_DESC(netconsole, "
>> netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]\n");
>> 
>> So, for example:
>> 
>> modprobe netconsole
>> netconsole=6666@192.168.1.1/eth0,6666@192.168.1.100/00:40:95:9A:12:34
>> 
>> -Jeff
>> 
>> 
shabanip> Payam Shabanian shabanip -at- avapajoohesh.com
>>
>>>> ==> Regarding Re: how to capture kernel panics; Christian Borntraeger
>>>> <linux-kernel@borntraeger.net> adds:
>>>> 
linux-kernel> shabanip wrote:
>>>>>> is there any way to capture and log kernel panics on disk or ...?
>>>>
linux-kernel> In former times, the Linux kernel tried to sync in the panic
linux-kernel> function. (If the panic did not happen in interrupt context)
linux-kernel> Unfortunately this had severe side effects in cases where
>>>> the
linux-kernel> panic was triggered by file system block device code or any
linux-kernel> other part which is necessary for syncing. In most cases the
linux-kernel> call trace never made it onto disk anyway. So currently the
linux-kernel> kernel does not support saving a panic.
>>>>
linux-kernel> Apart from using a serial console, you might have a look at
linux-kernel> several kexec/kdump/lkcd tools where people are working on
linux-kernel> being able to dump the memory of a paniced kernel.
>>>> Or netconsole, which will dump printk's do the server:port of your
>>>> choosing.
>>>> 
>>>> -Jeff
>>>> 
>>
shabanip> - To unsubscribe from this list: send the line "unsubscribe
shabanip> linux-kernel" in the body of a message to
shabanip> majordomo@vger.kernel.org More majordomo info at
shabanip> http://vger.kernel.org/majordomo-info.html Please read the FAQ
>> at
shabanip> http://www.tux.org/lkml/
>>
