Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbWHJGvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWHJGvb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWHJGvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:51:31 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:1191 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1161063AbWHJGva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:51:30 -0400
Message-ID: <44DAC892.7000100@cs.wisc.edu>
Date: Thu, 10 Aug 2006 01:48:02 -0400
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: stelian@popies.net, linux-kernel@vger.kernel.org, akpm@osdl.org,
       paulus@au1.ibm.com, anton@au1.ibm.com, open-iscsi@googlegroups.com,
       pradeep@us.ibm.com, mashirle@us.ibm.com
Subject: Re: [PATCH] memory ordering in __kfifo primitives
References: <20060810001823.GA3026@us.ibm.com> <20060810003310.GA3071@us.ibm.com>
In-Reply-To: <20060810003310.GA3071@us.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> OK, it appears that we are even.  I forgot to attach the promised
> analysis of the callers to __kfifo_put() and __kfifo_get(), and
> the open-iscsi@googlegroups.com email address listed as maintainer
> in drivers/scsi/libiscsi.c bounces complaining that, as a non-member,
> I am not allowed to send it email.  ;-)

Sorry about that. I do not have any control over the email list. I will
change the maintainer info entry to indicate that users should just send
mail to me or linux-scsi.

> 
> Anyway, this time the analysis really is attached, sorry for my confusion!
> 

We have change the code a little since the analysis was made. But, it
does not really matter much now. I am fine with us just grabbing the
session lock or xmitmitex (I will send a patch and test it as well) if
your barrier patch is not accepted. We grab the session lock in the fast
path now so there is not much benefit left for us.
