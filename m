Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWD0WzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWD0WzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWD0WzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:55:20 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:14237 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751611AbWD0WzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:55:19 -0400
In-Reply-To: <20060427114828.GC32127@wohnheim.fh-wedel.de>
References: <4450A1AD.7040506@de.ibm.com> <20060427114828.GC32127@wohnheim.fh-wedel.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6C0D7610-D6A3-43CC-9327-926948167D43@kernel.crashing.org>
Cc: Heiko J Schick <schihei@de.ibm.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, linuxppc-dev@ozlabs.org,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/16] ehca: event queue
Date: Fri, 28 Apr 2006 00:55:10 +0200
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +	if (ret != H_SUCCESS) {
>
> Common convention is to return 0 on success and -ESOMETHING on eror.
> You might want to follow that and remove H_SUCCESS from the complete
> code.

This return code doesn't come from anywhere within the kernel, though.
If we change this, we should get rid of _every_ #define bladibla 0
Do we want that?  (I do ;-) )

>> +		if (!(vpage = ipz_qpageit_get_inc(&eq->ipz_queue))) {
>
> I personally despise assignments in conditionals.  Not sure if this is
> documented in CodingStyle, but IME most kernel hackers tend to dislike
> it as well.

In this case it's obvious; put it on a separate line.


Segher

