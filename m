Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWIHQGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWIHQGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWIHQGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:06:15 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:33919 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750827AbWIHQGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:06:14 -0400
Message-ID: <450195B2.8000004@sw.ru>
Date: Fri, 08 Sep 2006 20:09:22 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
References: <44FC193C.4080205@openvz.org> <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org> <44FFF1A0.2060907@openvz.org> <Pine.LNX.4.64.0609070816170.27779@g5.osdl.org> <4501891D.5090607@sw.ru> <Pine.LNX.4.64.0609080831530.27779@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609080831530.27779@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 8 Sep 2006, Kirill Korotaev wrote:
> 
>>I even checked the email myself and the only difference between "good"
>>patches and mine is that mine has "format=flowed" in
>>Content-Type: text/plain; charset=us-ascii; format=flowed
>>
>>It looks like some mailers replace TABs with spaces when format=flowed
>>is specified. So are you sure that the problem is in mozilla?
> 
> 
> Hey, what do you know? Good call. I can actually just "S"ave the message 
> to a file, and it is a perfectly fine patch. But when I view it in my mail 
> reader, your "format=flowed" means that it _shows_ it as being corrupted 
> (ie word wrapping and missing spaces at the beginning of lines).
Oh, I finally found how to tune Mozilla and fix it:

One need to edit defaults/pref/mailnews.js file to have:
pref("mailnews.send_plaintext_flowed", false); // RFC 2646=======
pref("mailnews.display.disable_format_flowed_support", true);

This makes Mozilla to send emails w/o "format=flowed".

Thanks a lot for your patience :)

Kirill
