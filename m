Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVKUWv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVKUWv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVKUWv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:51:27 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:3289 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S1751131AbVKUWv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:51:26 -0500
Message-ID: <43824F57.1040007@nortel.com>
Date: Mon, 21 Nov 2005 16:51:03 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: kuznet@ms2.inr.ac.ru, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: netlink nlmsg_pid supposed to be pid or tid?
References: <E1EeJwF-0006wc-00@gondolin.me.apana.org.au>
In-Reply-To: <E1EeJwF-0006wc-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2005 22:51:05.0158 (UTC) FILETIME=[0DD46E60:01C5EEEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

> As I said before, you should not rely on getpid() to work.

> You should always use getsockaddr(2) to get your local address.

Should that be getsockname(2)?  Anyways, I now understand the issues.

As it turns out, we were actually already calling getsockname() a bit 
earlier in the code path, so we can just use the "pid" value from there.

Chris
