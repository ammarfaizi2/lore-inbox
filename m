Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVK1TOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVK1TOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVK1TOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:14:25 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:2962 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932192AbVK1TOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:14:23 -0500
Message-ID: <438B4E85.2060801@tmr.com>
Date: Mon, 28 Nov 2005 13:37:57 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jonmasters@gmail.com, cp@absolutedigital.net, linux-kernel@vger.kernel.org,
       jcm@jonmasters.org, torvalds@osdl.org, viro@ftp.linux.org.uk,
       hch@lst.de
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct
   ..."
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>	<20051116005958.25adcd4a.akpm@osdl.org>	<20051119034456.GA10526@apogee.jonmasters.org>	<20051121233131.793f0d04.akpm@osdl.org>	<35fb2e590511220356x75a951f1t8a36d0556a940751@mail.gmail.com> <20051122141628.41f3134f.akpm@osdl.org>
In-Reply-To: <20051122141628.41f3134f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jon Masters <jonmasters@gmail.com> wrote:
> 
>>On 11/22/05, Andrew Morton <akpm@osdl.org> wrote:
>>
>>
>>>That still does the wrong thing.  Put in a write-protected floppy, try to
>>>write to it and it says -EROFS.  Then pop the WP switch and try to
>>>write to it again and it wrongly claims EPERM.  A second attempt to
>>>write will succeed.
>>
>>The problem is that we need to wait until the floppy driver next
>>checks the read status on the drive. I think to get it completely
>>right will take moving bits of the floppy driver around, unless I'm
>>being stupid. I'm planning to do that too though.
>>
> 
> 
> In the meanwhile I think we should revert back to the 2.6.14 version of
> floppy.c - the present problem is probably worse than the one which it
> kinda-fixes.

I think that's best, because there are few people (relatively) using 
floppy, and those who are probably are used to old behaviour.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

