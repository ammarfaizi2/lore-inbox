Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVCAXfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVCAXfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVCAXfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:35:39 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:38602 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262086AbVCAXf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:35:29 -0500
Message-ID: <4224FC33.6040405@acm.org>
Date: Tue, 01 Mar 2005 17:35:15 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <greg@kroah.com>, Sergey Vlasov <vsu@altlinux.ru>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New operation for kref to help avoid locks
References: <42209BFD.8020908@acm.org>	 <20050226232026.5c12d5b0.vsu@altlinux.ru> <4220F6C8.4020002@acm.org>	 <20050301201528.GA23484@kroah.com>	 <1109710964.6293.166.camel@laptopd505.fenrus.org>	 <4224E499.5060800@acm.org> <1109715256.6293.180.camel@laptopd505.fenrus.org>
In-Reply-To: <1109715256.6293.180.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>Just doing an atomic operation is not faster than doing a lock, an 
>>atomic operation, then an unlock?  Am I missing something?
>>    
>>
>
>if the lock and the atomic are on the same cacheline they're the same
>cost on most modern cpus...
>  
>
Ah, I see.  Not likely to ever be the case with this.  The lock will 
likely be with the main data structure (the list, or whatever) and the 
refcount will be in the individual item in the main data structure (list 
entry).

-Corey
