Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270203AbTHGPqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270066AbTHGPqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:46:02 -0400
Received: from CS.ubishops.ca ([206.167.194.132]:650 "EHLO cs.ubishops.ca")
	by vger.kernel.org with ESMTP id S270203AbTHGPol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:44:41 -0400
Message-ID: <3F327382.5000200@cs.ubishops.ca>
Date: Thu, 07 Aug 2003 11:42:58 -0400
From: Patrick McLean <pmclean@cs.ubishops.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030731
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Interactivity improvements
References: <3F3261A2.9000405@cs.ubishops.ca> <20030807152418.GA509@malvern.uk.w2k.superh.com>
In-Reply-To: <20030807152418.GA509@malvern.uk.w2k.superh.com>
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard Curnow wrote:
> * Patrick McLean <pmclean@cs.ubishops.ca> [2003-08-07]:
> 
>>Another point is compilers, they tend to do a lot of disk I/O then 
>>become major CPU hogs, could we have some sort or heuristic that reduces 
>>the bonuses for sleeping on block I/O rather than other kinds of I/O 
>>(say pipes and network I/O in the case of X).
> 
> 
> What about compilers chewing on source files coming in over NFS rather
> than resident on local block devices?  The network waits need to be
> broken out into NFS versus other, or UDP versus TCP or something.  e.g.
> waits due to the user not having typed anything yet, or moved the mouse,
> are going to be on TCP connections.
> 
Maybe if we had it reduce sleeping bonuses if it's waiting on filesystem 
access, this would cover NFS as the kernel does consider it a 
filesystem, this would cover SMB, AFS, etc as well.

