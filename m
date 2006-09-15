Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWIODxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWIODxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 23:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWIODxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 23:53:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:38631 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751364AbWIODxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 23:53:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o377+nf7jkZAYk3woTsYMdb5L3HTjTvGRaEf2AxRE38lg+06/HTOiIGp7RrA5a4k1404eaiP8ALEm4UNwMHZVTuV63sU2645Mc9bhAXi4nqz5WaSDl80NBDSJL0wjtZgpKpM3YcY6A4e85KhezcMdRo7wiCAfNZN18AHlqWnQcQ=
Message-ID: <b263e5900609142053r12fbb71ep6ea3e1d63a722d4e@mail.gmail.com>
Date: Thu, 14 Sep 2006 20:53:16 -0700
From: "Dan Carpenter" <error27.lkml@gmail.com>
To: "Matt Domsch" <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Cc: linux-pci@atrey.karlin.mff.cuni.cz, "Greg KH" <greg@kroah.com>,
       linux-kernel@vger.kernel.org, error27@gmail.com,
       ppokorny@penguincomputing.com
In-Reply-To: <20060908031422.GA4549@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060908031422.GA4549@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/06, Matt Domsch <Matt_Domsch@dell.com> wrote:
> Problem:
> Many people have come to expect this naming.  Linux 2.6
> kernels name these eth1 and eth0 respectively (backwards from
> expectations).  I also have reports that various Sun and HP servers
> have similar behavior.
>

On RHEL3 the 32bit and 64bit versions order the NICs differently.
64bit RHEL3 orders it the same as 2.6.

I've got a lot of systems where the NIC LEDs are labelled.  The labels
are correct for 2.6 but not for 2.4 32 bit.  I'm suspect the labels
were designed for Windows originally.

My boss pointed out that this patch.  It was supposed to make PCI bus
ordering match 2.4.
http://kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commitdiff;h=ffdd6e8f870ca6dd0d9b9169b8c2e0fdbae99549
It's still there, why did it stop working?

Couldn't we just use the labelling from the DMI data to order the NICs?

regards,
dan carpenter
