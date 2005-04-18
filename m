Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVDRGfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVDRGfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 02:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVDRGfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 02:35:42 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:12186 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261800AbVDRGfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 02:35:36 -0400
Message-ID: <42635518.6040704@nortel.com>
Date: Mon, 18 Apr 2005 00:35:04 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org>
In-Reply-To: <20050418061221.GA32315@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Mon, Apr 18, 2005 at 01:19:57PM +0900, Takashi Ikebe wrote:
> 
> 
>>From our experience, sometimes patches became to dozens to hundreds
>>at one patching, and in this case GDB based approach cause target
>>process's availability descent.

> could you perhaps explain some *real* *world* applications/systems
> where this is necessary and why existing APIs won't work with them
> perhaps?

In the telecom space it's quite common to want to modify multiple 
running binaries with as little downtime as possible.  (Beyond a 
threshold it becomes FCC-reportable in the US, and everyone wants to 
avoid that...)

Our old proprietary OS had explicit support for replacing running binary 
code on the fly, so customers have gotten used to the ability.  Now they 
want equivalent functionality with our linux-based stuff.

We've done some proprietary stuff (ie. pre-OSDL CGL) in this area, but 
it was apparently a real pain and was quite restrictive on the 
application writers. (I was not involved with that portion of the project.)

For general application support I suspect some kernel support will be 
required.  Whether this is the way to go or whether it can be done using 
existing mechanisms, I'm not knowledgeable enough to comment.

Chris
