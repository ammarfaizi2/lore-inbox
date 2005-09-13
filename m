Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVIMO3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVIMO3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVIMO3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:29:39 -0400
Received: from magic.adaptec.com ([216.52.22.17]:15790 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932648AbVIMO3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:29:38 -0400
Message-ID: <4326E24B.6030000@adaptec.com>
Date: Tue, 13 Sep 2005 10:29:31 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 2/14] sas-class: README
References: <4321E4DD.7070405@adaptec.com> <432543C6.1020403@torque.net> <4325CB10.1020902@adaptec.com> <4326A635.3020400@torque.net> <4326D48E.1080305@adaptec.com>
In-Reply-To: <4326D48E.1080305@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2005 14:29:37.0581 (UTC) FILETIME=[91BBC5D0:01C5B86F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/05 09:30, Luben Tuikov wrote:
> I cannot call it a "passthrough" since the SMP frame isn't
> "passing though" (by passing) anything.  When userspace
> does a read(2) to get the data they expect, the SMP
> frame they wrote(2) is sent to the SDS immediately.
> In effect there is no "passing through".
> 
> It is a _protocol_ interjection.
> 
> That is an SMP frame (submission) _instantiates_
> at that layer/level, not lower, not higher.
> 
> 
>>one dispenses with a bit of metadata such as per command
>>timeouts and 3 levels of error messages (i.e. from the

I forgot to mention -- SMP transport has a hardware timer
as well as software one.  read(2) will never hang.

If there's no one on the other end, we get an error,
and read(2) less (or none) information than we requested.

	Luben
