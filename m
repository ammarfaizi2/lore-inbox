Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVCVCoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVCVCoH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVCVCnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:43:53 -0500
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:38892 "EHLO
	bgo1smout1.broadpark.no") by vger.kernel.org with ESMTP
	id S262283AbVCVB7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:59:41 -0500
Date: Tue, 22 Mar 2005 03:01:01 +0100
From: Daniel Andersen <anddan@linux-user.net>
Subject: Re: Distinguish real vs. virtual CPUs?
In-reply-to: <20050321202726.A7630@morpheus>
To: Dan Maas <dmaas@maasdigital.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <423F7C5D.4000203@linux-user.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <20050321202726.A7630@morpheus>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Maas wrote:
> Is there a canonical way for user-space software to determine how many
> real CPUs are present in a system (as opposed to HyperThreaded or
> otherwise virtual CPUs)?
> 
> We have an application that for performance reasons wants to run one
> process per CPU. However, on a HyperThreaded system /proc/cpuinfo
> lists two CPUs, and running two processes in this case is the wrong
> thing to do. (Hyperthreading ends up degrading our performance,
> perhaps due to cache or bus contention).
> 
> Please CC replies.
> 
> Thanks,
> Dan Maas
> -

The simplest thing to do would be to boot with the "noht" parameter.

Or you can use "schedtool" (google or freshmeat) to set the CPU-affinity 
at runtime to avoid HyperThreading the processes.

Daniel Andersen

-- 
