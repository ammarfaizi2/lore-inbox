Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbUDBUVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 15:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbUDBUVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 15:21:05 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:58514 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262885AbUDBUVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 15:21:02 -0500
Message-ID: <406DCB32.8070403@stanford.edu>
Date: Fri, 02 Apr 2004 22:21:06 +0200
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       luto@myrealbox.com, linux-kernel@vger.kernel.org
Subject: Re: capabilitiescompute_cred
References: <20040402033231.05c0c337.akpm@osdl.org> <1080912069.27706.42.camel@moss-spartans.epoch.ncsc.mil> <20040402111554.E21045@build.pdx.osdl.net>
In-Reply-To: <20040402111554.E21045@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
>>IMHO, capabilities are a broken idea anyway, and should ultimately be
>>replaced entirely using Type Enforcement (which SELinux includes).  A
>>comparison of the two approaches is in
>>http://www.securecomputing.com/pdf/secureos.pdf.  Today we still stack
>>SELinux with the capabilities module, but long term, I'd like to see us
>>just drop capabilities and use TE by itself to manage privileges.
> 
> 
> I have the same dislike for capabilities.  It's more like a wart than
> a feature.  I get requests to have RBAC be the core priv system rather
> than capabilities.

I agree in principle, but it would still be nice to have a simple way to 
have useful capabilities without setting up a MAC system.  I don't see a 
capabilities fix adding any significant amount of code; it just takes 
some effort to get it right.

> 
> In the meantime, I've often idly wondered why we don't simply inherit as
> advertised.  The patch below does this, but I haven't even started
> looking for security sensitive failure modes.

I'm not sure that introduces security problems, but I'm also not sure it 
fixes much.  You can find my attempts to get it right in the 
linux-kernel archives, and I'll probably try to get something into 2.7 
when it forks.  With or without MAC, having a functioning capability 
system wouldn't hurt security.

> 
> thanks,
> -chris
