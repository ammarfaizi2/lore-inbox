Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbULQTd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbULQTd1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbULQTaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:30:30 -0500
Received: from neopsis.com ([213.239.204.14]:41603 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S262137AbULQTaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:30:06 -0500
Message-ID: <41C334DF.107@dbservice.com>
Date: Fri, 17 Dec 2004 20:34:55 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
Cc: jmorris@redhat.com, kaber@trash.net, bryan@coverity.com,
       netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Coverity] Untrusted user data in kernel
References: <Xine.LNX.4.44.0412170144410.12579-100000@thoron.boston.redhat.com>	<41C2DCBC.1080302@dbservice.com> <20041217111634.740d4d46.davem@davemloft.net>
In-Reply-To: <20041217111634.740d4d46.davem@davemloft.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Fri, 17 Dec 2004 14:18:52 +0100
> Tomas Carnecky <tom@dbservice.com> wrote:
> 
> 
>>IMHO such things (passing values between user/kernel space) should 
>>always be checked.
> 
> 
> As per Patrick's posting, which James was responding to, it is
> checked at the level above this function.

Is only the capability checked or also the data passed to the kernel?
It's not clear from Patricks reply:
 > It is already checked in do_ip6t_set_ctl(). Otherwise anyone could
 > replace iptables rules :)
For me it seems that only CAP_NET_ADMIN is checked and not the data.

tom
