Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbVIFB34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbVIFB34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 21:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbVIFB34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 21:29:56 -0400
Received: from smtpout.mac.com ([17.250.248.46]:44240 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965065AbVIFB3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 21:29:55 -0400
In-Reply-To: <5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050903064124.GA31400@codepoet.org> <4319BEF5.2070000@zytor.com> <B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com> <dfhs4u$1ld$1@terminus.zytor.com> <5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined by GCC from 2.95 to current CVS)
Date: Mon, 5 Sep 2005 21:29:27 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 5, 2005, at 19:28:07, Kyle Moffett wrote:
> With all of that mess out of the way, I'll work on getting a few  
> initial RFC
> patches out the door, and then we can revisit this discussion once  
> there is
> something tangible to talk about.

Ugh.  Step one for my cleanup is to rename __ASSEMBLY__ to something  
defined
automatically by GCC (IE: __ASSEMBLER__).  And yes, I checked,  
__ASSEMBLER__
is defined by everything from old 2.95 to 4.0, even though it wasn't  
really
documented in anything older than 3.4.  This megapatch is basically a  
search
and replace of __ASSEMBLY__ with __ASSEMBLER__ over the whole kernel  
source,
except in Makefiles, where I just delete the -D__ASSEMBLY__  
argument.  If
this is generally acceptable, I'll break it up into small digestible  
pieces
and send to individual maintainers, unless someone wants to pass the  
whole
monster through their tree in one big lump.  This is a lot of code  
churn,
but it's a valid cleanup and will help me out as I try to make more  
of the
kernel headers easily digestible for userspace.

Ok, the patch itself is temporarily located here (Please be nice to my
desktop, it has a 650MB/day upload limit imposed by Virginia Tech  
that I'd
rather not go over) [patch is 308k]:

http://zeus.moffetthome.net/~kyle/rename-__ASSEMBLY__-to- 
__ASSEMBLER__.patch

And here's the diffstat [27k]

http://zeus.moffetthome.net/~kyle/rename-__ASSEMBLY__-to- 
__ASSEMBLER__.diffstat

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that
would also stop them from doing clever things.
   -- Doug Gwyn



