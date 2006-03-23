Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWCWJeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWCWJeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWCWJeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:34:17 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:42467 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751407AbWCWJeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:34:16 -0500
In-Reply-To: <1143101972.3147.11.camel@laptopd505.fenrus.org>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk> <1143101972.3147.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a15cee148267ad7406a077c28c0c97ac@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, ian.pratt@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
Date: Thu, 23 Mar 2006 09:34:34 +0000
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23 Mar 2006, at 08:19, Arjan van de Ven wrote:

>> We certainly should be pushing everyone toward using the 'xdX' etc
>> devices that are allocated to us.
>
> yes but you are faking something stupid ;)
> You aren't ide, you don't take the IDE ioctls. So please just nuke this
> bit..

Well, that's plausible. We probably don't need IDE *and* SCSI faking. 
We'd like to at least keep SCSI faking, perhaps making it more 
attractive by going to some effort to take at least the essential SCSI 
ioctls. We've talked about reving our block protocol to encapsulate 
SCSI anyway -- this would be another step on that path.

If we stick to just our own major then we break distro init scripts and 
surprise users.

  -- Keir

