Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbULQTN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbULQTN5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbULQTN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:13:57 -0500
Received: from neopsis.com ([213.239.204.14]:28035 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S262120AbULQTNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:13:55 -0500
Message-ID: <41C330F7.4000806@dbservice.com>
Date: Fri, 17 Dec 2004 20:18:15 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
Cc: Bill Davidsen <davidsen@tmr.com>, James Morris <jmorris@redhat.com>,
       Patrick McHardy <kaber@trash.net>, Bryan Fulton <bryan@coverity.com>,
       netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Coverity] Untrusted user data in kernel
References: <41C26DD1.7070006@trash.net> <Xine.LNX.4.44.0412170144410.12579-100000@thoron.boston.redhat.com> <41C2FF99.3020908@tmr.com> <Pine.LNX.4.61.0412171108340.4216@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0412171108340.4216@chaos.analogic.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> On Fri, 17 Dec 2004, Bill Davidsen wrote:
> 
>> James Morris wrote:
>>
>>> On Fri, 17 Dec 2004, Patrick McHardy wrote:
 >>>
>>> That's what I meant, you need the capability to do anything bad :-)
>>
>>
>> Are you saying that processes with capability don't make mistakes? 
>> This isn't a bug related to untrusted users doing privileged 
>> operations, it's a case of using unchecked user data.
>>
> 
> But isn't there always the possibility of "unchecked user data"?
> I can, as root, do `cp /dev/zero /dev/mem` and have the most
> spectacular crask you've evet seen. I can even make my file-
> systems unrecoverable.
> 

But the difference between you example (cp /dev/zero /dev/mem) and 
passing unchecked data to the kernel is... you _can_ check the data and 
do something about it if you discover that the data is not valid/within 
a range/whatever even if the user has full permissions.
No same person would do a 'cp /dev/zero /dev/mem', but passing bad data 
is more likely to happen, badly written userspace configuration tools etc.

tom
