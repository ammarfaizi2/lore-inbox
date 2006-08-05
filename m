Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWHETDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWHETDx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 15:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWHETDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 15:03:51 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:20767 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751469AbWHETDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 15:03:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Cm+o1Lm9+wQtif8pK//p3npu4CWVHeALopskrGKtRZASU1N/t2sC7JE9Jwr/gdS2cXtc324yPXeJV58O1XlZ7bUwWNEVWsX+pKcMY6zN4m8Ez10ixthjUFKIl5lSS5Sf5NZT1I+0Y9ImJLEOaNVZaoYEReExwCrrnl5wErN+180=
Message-ID: <44D4EB88.6050406@gmail.com>
Date: Sat, 05 Aug 2006 21:03:36 +0200
From: RazorBlu <razorblu@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ACLs
References: <44D3BF62.10202@gmail.com> <1154729992.3573.35.camel@brianb> <44D3CFB9.9020208@gmail.com> <F493D385-0915-442A-853A-00B3ED75B8B2@mac.com> <44D3DE48.8060103@gmail.com> <20060805014722.GA19509@mail>
In-Reply-To: <20060805014722.GA19509@mail>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Crilly wrote:
> It's been in the stable release of every kernel for quite some time now.
> And it's enabled by default in FC5 and maybe RHEL4, I can't remember 100%
> about the latter. And I'm not 100% sure what all GRSecurity does, but from
> what I remember it covers a different area than SELinux so they're not
> comparable.

>
> The main reason it's not enabled by default in most distributions is that
> writing good policies is a huge amount of work and they haven't written
> policies for all of their packages. Now that SELinux has been pushed into
> FC it'll act as motivation for people to get working on those policies so I
> would guess that we'll see SELinux be enabled in the rest of the major
> distributions by default in their next releases or so.
That is part of my point. The ACL system included with Linux (whether it 
be the POSIX ACLs or SELinux) are too complex for use by most system 
administrators, and so are overlooked. Actually, that last statement is 
untrue - POSIX ACLs seem to be lacking slightly in functionality, and 
SELinux is overly complicated (see a previous reply in which someone 
else said that). AppArmor seems to be heading along the right tracks, 
because it can automatically create its own profiles which you can then 
tune as necessary, so it does not require as much work to create a 
policy for a service. However, it probably won't be included in the 
kernel, especially in the near future (SELinux, which is associated with 
the NSA, is already there - why add another one, even if it is more 
advanced?)
>
> To varying extents everything is still under research. AFAIK the core of
> SELinux hasn't changed in many years, it's just taken this long for people
> to figure out how to apply it properly.
And people still don't know how to apply it properly. How many system 
administrators do you see using SELinux? In contrast, how many do you 
now see using AppArmor, which has not been around anywhere near as long 
SELinux?

You can't blame advertising - AppArmor may be backed by Novell, but 
SELinux has the recognition of having ties with the NSA. Then what is 
it? Ease of use? The fact that a system like that does not have to have 
overly complicated usermode tools to configure the ACLs?
>
> Sure if you can break into sshd you might be able to mess with it's config
> files and any other areas on the system that everyone has access too, but
> that's it. But if you just login via ssh you'll only have access to the
> files that your account has access to, not sshd.
Assuming that sshd hasn't been locked down.. What if a vulnerability is 
found, and an exploit comes out before a patch, and sshd is compromised? 
Or your root password is brute-forced? What happens then? The attacker 
has root access, and thus access to EVERYTHING on your server (Windows 
has the reference monitor, which can't be tampered with or turned off... 
But we'll leave that aside for now). And unless you have bound sshd to a 
non-default port above 1023, you have to run it as root - but are you 
willing to sacrifice usability for security which can be bypassed anyway 
(privilege escalation)?

If the services are not locked down to just the files and folders they 
need access to (and with respective permissions), then the attacker 
gains full control over your server.

And one last thing - if I locked sshd down (I'm not sure whether your 
example is a locked down sshd or a standard one), I wouldn't let it 
access everyone's files ;)
> Precisely what? What's defined in POSIX ACLs wouldn't apply well to
> processes anyway since they were designed for file access. SELinux was
> created to deal with what you're talking about, why not use it?
Because SELinux is too complicated to be used effectively by most system 
administrators - that's why.

Alan Cox wrote:


> That was a while ago, oh way back in 2002. Update to a modern
> distribution and a file system that supports ACLs and you'll get ACLs
> and depending on the distro also SELinux.

But the POSIX ACLs aren't really flexible enough - hence the reason that they have not received the popularity and widespread usage they supposedly deserve.

