Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVD0Pwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVD0Pwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVD0Pwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:52:34 -0400
Received: from magic.adaptec.com ([216.52.22.17]:43493 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261629AbVD0PwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:52:16 -0400
Message-ID: <426FB52B.7080907@adaptec.com>
Date: Wed, 27 Apr 2005 11:52:11 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Peschke3 <MPESCHKE@de.ibm.com>
CC: dougg@torque.net, andrew.patterson@hp.com, Eric.Moore@lsil.com,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Madhuresh_Nagshain@adaptec.com, mike.miller@hp.com
Subject: Re: [RFC] SAS domain layout for Linux sysfs
References: <OF4CE413A0.DAB8B74B-ONC1256FF0.00505593-C1256FF0.0052A229@de.ibm.com>
In-Reply-To: <OF4CE413A0.DAB8B74B-ONC1256FF0.00505593-C1256FF0.0052A229@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2005 15:52:12.0991 (UTC) FILETIME=[13F814F0:01C54B41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/05 10:54, Martin Peschke3 wrote:
> Douglas Gilbert wrote
> 
>>It has been stated that the SAS discovery algorithm (i.e. the
>>recursive use of SMP) should be implemented once in the SAS
>>transport layer so that all SAS LLDs can use it. Putting
>>the SAS discovery algorithm in the user space may be
>>even more politically correct.
> 
> 
> Similarly, in the case of Fibre Channel, a common N_Port or
> SCSI target device discovery, preferably in user space, seems
> to be desirable. This would require some CT and / or ELS
> passthrough interface, for example in order to issue queries
> to fabric switches.

This is exactly what this RFC is all about.  Having
such a representation of "what is out there", for SAS,
in sysfs, you can "address" such devices via their
sysfs file, send SMP frames to their ports, etc.

BTW, it is possible for a boot device to be on
the SAS domain.  I think it may be most convenient for
discovery (at least a basic one) to be contained in the kernel.
Implications are security, reliability, immediate access, etc.

	Luben

