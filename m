Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWDEORi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWDEORi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 10:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWDEORh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 10:17:37 -0400
Received: from smtpout.mac.com ([17.250.248.46]:49388 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750828AbWDEORh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 10:17:37 -0400
In-Reply-To: <200604051350.k35DoIXF009872@wildsau.enemy.org>
References: <200604051350.k35DoIXF009872@wildsau.enemy.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <296FAFD9-3D3E-421C-A474-1998BCB8F718@mac.com>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Q on audit, audit-syscall
Date: Wed, 5 Apr 2006 10:17:30 -0400
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 5, 2006, at 09:50:17, Herbert Rosmanith wrote:
>> On Apr 5, 2006, at 08:06:30, Herbert Rosmanith wrote:
>>> as I said, "ptrace" is not an option.
>>
>> Why not, exactly?  (No, we don't know why).
>
> according to the man-page:
>
> RETURN VALUES
>      EPERM   The specified process [...] is already being traced.
>
> this makes it unusable for me.

Please stop being unclear and describe _exactly_ what you want to do;  
otherwise it's impossible to help you.  You want to trace and  
intercept syscalls, no?  It implicitly doesn't make any sense to try  
to trace and intercept syscalls from one process in more than one other.

>> ptrace is _the_ Linux  mechanism to trace and intercept syscalls.   
>> There is no other way.
> "there is no other way": [1,2,3,4]
>
> [1] http://www.uniforum.chi.il.us/slides/HardeningLinux/LAuS- 
> Design.pdf
> [2] http://www.usenix.org/publications/library/proceedings/als01/ 
> full_papers/edwards/edwards.pdf
> [3] http://www.citi.umich.edu/u/provos/papers/systrace.pdf
> [4] http://www.nsa.gov/selinux/papers/freenix01.pdf

It looks like you solved your own problem, then!  Feel free to use  
any one of those.  The only commonly-available mainline mechanism to  
_trace_ and _intercept_ syscalls is ptrace.  If you happen to be  
looking for how to implement extra process security checks, might I  
suggest looking at Linux Security Modules?  On the other hand, I  
think LSMs may never even see some requests if they fail access- 
restrictions before calling into the LSM.  I believe there's  
documentation on them in the linux/Documentation dir of your copies  
of the linux sources.

Cheers,
Kyle Moffett

