Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSFFAYv>; Wed, 5 Jun 2002 20:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSFFAYu>; Wed, 5 Jun 2002 20:24:50 -0400
Received: from bitmover.com ([192.132.92.2]:34215 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316579AbSFFAYt>;
	Wed, 5 Jun 2002 20:24:49 -0400
Date: Wed, 5 Jun 2002 17:24:49 -0700
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: bcrl@redhat.com, lord@sgi.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [RFC] 4KB stack + irq stack for x86
Message-ID: <20020605172449.K2938@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"David S. Miller" <davem@redhat.com>, bcrl@redhat.com, lord@sgi.com,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20020604225539.F9111@redhat.com> <1023315323.17160.522.camel@jen.americas.sgi.com> <20020605183152.H4697@redhat.com> <20020605.161342.71552259.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 04:13:42PM -0700, David S. Miller wrote:
>    From: Benjamin LaHaise <bcrl@redhat.com>
>    Date: Wed, 5 Jun 2002 18:31:52 -0400
> 
>    On Wed, Jun 05, 2002 at 05:15:23PM -0500, Steve Lord wrote:
>    > Just what are the tasks you normally run - and how many code
>    > paths do you think there are out there which you do not run. XFS
>    > might get a bit stack hungry in places, we try to keep it down,
>    > but when you get into file system land things can stack up quickly:
>    
>    You already lose in that case today, as multiple irqs may come in 
>    from devices and eat up the stack.
> 
> I agree with Ben, if things explode due to stack overflow with his
> changes they are almost certain to explode before his changes.

Just a "me too".  I like Ben's patch, it seems like it is a sort of
"bloat meter", if you overflow the stack that suggests something is
wrong, and it isn't stack size.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
