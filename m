Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTDWX1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbTDWX1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:27:12 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:38047 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264310AbTDWX1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:27:10 -0400
Date: Wed, 23 Apr 2003 16:28:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>
cc: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <1584040000.1051140524@flay>
In-Reply-To: <1051136725.4439.5.camel@laptop-linux>
References: <20030423135100.GA320@elf.ucw.cz><Pine.GSO.4.21.0304231631560.1343-100000@vervain.sonytel.be><20030423144705.GA2823@elf.ucw.cz> <20030423175629.7cfc9087.gigerstyle@gmx.ch><1051126871.1893.35.camel@laptop-linux><20030423223639.7cc6a796.gigerstyle@gmx.ch> <1051136725.4439.5.camel@laptop-linux>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2003-04-24 at 08:36, Marc Giger wrote:
>> Ok! I see the advantages / disadvantages of each version. But what
>> happens if the memory AND swap space are full and nothing can't be
>> freed? When I watch the memory and swap consumption on my laptop, I
>> think it's the most time the case...
> 
> If you're getting yourself in that situation, you should be increasing
> your swap space (and memory if possible) anyway.
> 
>> Another question:
>> Is it a big problem to save the memory in a separate file on the file
>> system, and save somewhere the pointer to it (as example in swap. Also
>> we could set a flag in swap so that we now that the last shutdown was
>> a hybernation). One Problem will be, that we don't know the filesystem
>> type on resume...(We could save the module in swap...)
>> All that is just theoretical. It's only a idea.
> 
> I guess the simplest answer is would it be worth the pain? Since disk
> space is cheap, it just requires a little forethought when installing
> Linux, to ensure enough swap is allocated. I certainly understand that
> using a file rather than swap makes adjusting the amount of space
> available easier, but as you rightly acknowledge, it does complicate
> things a fair bit more.

Can't you just create a pre-reserved separate swsusp area on disk the size 
of RAM (maybe a partition rather than a file to make things easier), and 
then you know you're safe (basically what Marc was suggesting, except pre-allocated)? Or does that make me the prince of all evil? ;-)

However much swap space you allocate, it can always all be used, so that
seems futile ...

M.

