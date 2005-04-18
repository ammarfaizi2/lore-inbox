Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVDREV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVDREV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 00:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVDREV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 00:21:57 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:26593 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261649AbVDREVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 00:21:54 -0400
Message-ID: <4263356D.9080007@lab.ntt.co.jp>
Date: Mon, 18 Apr 2005 13:19:57 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org>
In-Reply-To: <20050418040718.GA31163@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Chris Wedgwood wrote:
> On Mon, Apr 18, 2005 at 12:19:54PM +0900, Takashi Ikebe wrote:
>  
>>This patch add function called "Live patching" which is defined on
>>OSDL's carrier grade linux requiremnt definition to linux 2.6.11.7
>>kernel.
> I;m curious as to what people decided this was a necessary
> requirement.

The requirements are comes from Network Equipment Providers, Telecom 
Carriers, and Hardware Vendors,
You can see the attendee from below link;
http://groups.osdl.org/world_map/full_roster/

>>The live patching allows process to patch on-line (without
>>restarting process) on i386 and x86_64 architectures, by overwriting
>>jump assembly code on entry point of functions which you want to
>>fix, to patched functions.
> Why can't you use ptrace for all this?

GDB based approach seems not fit to our requirements. GDB(ptrace) based 
functions are basically need to be done when target process is stopping.
In addition to that current PTRACE_PEEK/POKE* allows us to copy only a 
*word* size...
 From our experience, sometimes patches became to dozens to hundreds at 
one patching, and in this case GDB based approach cause target process's 
availability descent.

-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp
