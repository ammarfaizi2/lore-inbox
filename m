Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWGUV5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWGUV5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 17:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWGUV5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 17:57:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:36680 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751221AbWGUV5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 17:57:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TO9+MP0geoCM0MxFuQmvGR8uHczxWjy29Uk2XVgguYF6927+jXPsSJkALB+c2QFuD/p3A41HLaiEYW6Hz0fWfESDmvRSaUaUTqNim+1u0wqQTf0D+OiKx1i8YoKIdpC717RQdkuGiSXXV7An9cJWKt9qCoEz3nP4VIeocKPHV9Q=
Message-ID: <bda6d13a0607211457k596e912fx845c68c2daa298f6@mail.gmail.com>
Date: Fri, 21 Jul 2006 14:57:20 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: what is necessary for directory hard links
In-Reply-To: <20060721202825.GB29656@robsims.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bda6d13a0607201804je89fc3exd0b8f821509a3894@mail.gmail.com>
	 <20060721202825.GB29656@robsims.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some people seem to think that I am proposing to do something.
Understand that I have done it for 2.6.17-rc4 and am currently
involved in bringing it forward to newer kernels.

>
> What is the parent of a hard linked directory?  What is the parent if
> the link in "the parent" is deleted?

The parent is any and all directories that contain a link to the
stated directory.  ".." points back along the path the referrer used
to reach the current directory (this behavior is already in kernel:
didn't have to lift a finger to get it).
