Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVANUPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVANUPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVANUPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:15:43 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:7926 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262127AbVANUOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:14:50 -0500
Message-ID: <41E8282F.8060208@comcast.net>
Date: Fri, 14 Jan 2005 14:14:39 -0600
From: Tom Zanussi <zanussi@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH 4/4] relayfs for 2.6.10: headers
References: <41E736C4.3080806@opersys.com> <20050114191013.GB15337@kroah.com>
In-Reply-To: <20050114191013.GB15337@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Jan 13, 2005 at 10:04:36PM -0500, Karim Yaghmour wrote:
> 
>>+/**
>>+ *	have_cmpxchg - does this architecture have a cmpxchg?
>>+ *
>>+ *	Returns 1 if this architecture has a cmpxchg useable by
>>+ *	the lockless scheme, 0 otherwise.
>>+ */
>>+static inline int
>>+have_cmpxchg(void)
>>+{
>>+#if defined(__HAVE_ARCH_CMPXCHG)
>>+	return 1;
>>+#else
>>+	return 0;
>>+#endif
>>+}
> 
> 
> Shouldn't this be a build time check, and not a runtime one?
> 

This was to avoid having an ifdef in the main body of the code.  It's 
only used in channel setup, so I did'nt worrry about runtime checking.

Thanks,

Tom

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

