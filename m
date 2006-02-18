Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWBRCFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWBRCFc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 21:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWBRCFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 21:05:18 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:34397 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750723AbWBRCFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 21:05:01 -0500
To: Greg KH <greg@kroah.com>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, openib-general@openib.org,
       SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: Re: [PATCH 02/22] Firmware interface code for IB device.
X-Message-Flag: Warning: May contain useful information
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
	<20060218005707.13620.20538.stgit@localhost.localdomain>
	<20060218015808.GB17653@kroah.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 17 Feb 2006 18:04:56 -0800
In-Reply-To: <20060218015808.GB17653@kroah.com> (Greg KH's message of "Fri,
 17 Feb 2006 17:58:08 -0800")
Message-ID: <aday809bewn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Feb 2006 02:04:56.0968 (UTC) FILETIME=[B747C880:01C6342F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Roland, your comments are fine, but what about the original
    Greg> author's descriptions of what each patch are?

This is actually me breaking up a giant driver into pieces small
enough to post to lkml without hitting the 100 KB limit.

This is just an RFC -- I assume the driver is going to get merged in
the end as one big git changeset with a changelog like "add driver for
IBM eHCA InfiniBand adapters".

    Greg> Come on, IBM allows developers to post code to lkml, just
    Greg> look at the archives for proof.  For them to use a proxy
    Greg> like this is very strange, and also, there is no
    Greg> Signed-off-by: record from the original authors, which is
    Greg> not ok.

Well, the eHCA guys tell me that they can't post patches to lkml.

You're right that the final merge will have to have an IBM
Signed-off-by: line but as I said this is just an RFC.  There are many
reasons beyond patch format issues that make this stuff unmergeable as-is.

    Greg> And why aren't you using the standard firmware interface in
    Greg> the kernel?

This is actually stuff to talk to the firmware that sits below the
kernel on IBM ppc64 machines, not an interface to load device firmware
from userspace.

 - R.
