Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVHJJME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVHJJME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 05:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVHJJME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 05:12:04 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:9091 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S932420AbVHJJMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 05:12:01 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.96,95,1122847200"; 
   d="scan'208"; a="13866254:sNHT27738664"
Message-ID: <42F9C4DB.8010001@fujitsu-siemens.com>
Date: Wed, 10 Aug 2005 11:11:55 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Robert Wilkens <robw@optonline.net>
Subject: Re: Signal handling possibly wrong
References: <42F8EB66.8020002@fujitsu-siemens.com> <1123612016.3167.3.camel@localhost.localdomain> <42F8F6CC.7090709@fujitsu-siemens.com> <1123612789.3167.9.camel@localhost.localdomain> <42F8F98B.3080908@fujitsu-siemens.com> <1123614253.3167.18.camel@localhost.localdomain> <1123615983.18332.194.camel@localhost.localdomain> <42F906EB.6060106@fujitsu-siemens.com> <1123617812.18332.199.camel@localhost.localdomain> <1123618745.18332.204.camel@localhost.localdomain> <20050809204928.GH7991@shell0.pdx.osdl.net>
In-Reply-To: <20050809204928.GH7991@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Steven Rostedt (rostedt@goodmis.org) wrote:
> 
>>Where, sa_mask is _ignored_ if NODEFER is set. (I now have woken up!).
>>The attached program shows that the sa_mask is indeed ignored when
>>SA_NODEFER is set.
>>
>>Now the real question is... Is this a bug?
> 
> 
> That's not correct w.r.t. SUSv3.  sa_mask should be always used and
> SA_NODEFER is just whether or not to add that signal in.
> 
> SA_NODEFER
>     [XSI] If set and sig is caught, sig shall not be added to the thread's
>     signal mask on entry to the signal handler unless it is included in
>     sa_mask. Otherwise, sig shall always be added to the thread's signal
>     mask on entry to the signal handler.
> 
> Brodo, is this what you mean?
> 
> thanks,
> -chris
> --
Yes. That's the difference between kernel and man page, that I've found.
I like the patch, at least the version Steven has sent. But at the end,
others have to decide if kernel or man page should be changed.

BTW: would you please call me Bodo? :-)

Regards
	Bodo
