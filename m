Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWCVQxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWCVQxD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWCVQxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:53:03 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:3220 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751378AbWCVQxB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:53:01 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [RFC PATCH 35/35] Add Xen virtual block device driver.
Date: Wed, 22 Mar 2006 16:52:56 -0000
Message-ID: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 35/35] Add Xen virtual block device driver.
Thread-Index: AcZNz0hJFV4ICdaLQbCU0ksDc45R+AAAS3AA
From: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>
To: "Anthony Liguori" <aliguori@us.ibm.com>,
       "Chris Wright" <chrisw@sous-sol.org>
Cc: <virtualization@lists.osdl.org>, <xen-devel@lists.xensource.com>,
       <linux-kernel@vger.kernel.org>, "Ian Pratt" <ian.pratt@xensource.com>,
       <ian.pratt@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is another thing that has always put me off.  The 
> virtual block device driver has the ability to masquerade as 
> other types of block devices.  It actually claims to be an 
> IDE or SCSI device allocating the appropriate major/minor numbers.
> 
> This seems to be pretty evil and creating interesting failure 
> conditions for users who load IDE or SCSI modules.  I've seen 
> it trip up a number of people in the past.  I think we should 
> only ever use the major number that was actually allocated to us.

We certainly should be pushing everyone toward using the 'xdX' etc
devices that are allocated to us. However, the installers of certain
older distros and other user space tools won't except anything other
than hdX/sdX, so its useful from a compatibility POV even if it never
goes into mainline, which I agree it probably shouldn't. 

Ian
