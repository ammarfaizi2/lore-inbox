Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUDZM3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUDZM3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 08:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUDZM3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 08:29:33 -0400
Received: from pxy1allmi.all.mi.charter.com ([24.247.15.38]:29839 "EHLO
	proxy1.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S264530AbUDZM3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 08:29:31 -0400
Message-ID: <408D00EE.5020703@quark.didntduck.org>
Date: Mon, 26 Apr 2004 08:30:38 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040422
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix warning in prefetch_range
References: <408AFD6C.9080100@quark.didntduck.org> <20040425220837.315726d1.akpm@osdl.org>
In-Reply-To: <20040425220837.315726d1.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Brian Gerst <bgerst@didntduck.org> wrote:
> 
>>Fix this warning:
>>include/linux/prefetch.h: In function `prefetch_range':
>>include/linux/prefetch.h:62: warning: pointer of type `void *' used in 
>>arithmetic
>>
> 
> 
> eh?  That's a gcc extension which has worked silently since forever.
> 
> What compiler version is generating the warning?
> 

gcc (GCC) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)

I saw the warning when compiling the nvidia driver, which uses 
-Wpointer-arith.  I'll drop that switch instead.

--
				Brian Gerst
