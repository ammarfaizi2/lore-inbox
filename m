Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161589AbWHDXzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161589AbWHDXzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161587AbWHDXzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:55:04 -0400
Received: from hu-out-0102.google.com ([72.14.214.207]:50892 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161589AbWHDXzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:55:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Utl0cOYIHtysPspn3ex6zohS7yHE1jrh6GiaUyAPswYtQBTYKwXWJ2MKPQ1Mdgxq9BI7Rpn2qLsns8kTUmEYm8aoUpUyh0cHwwx51tz1fRVEEebdDSKIlH5X9dXhiLBfVzGKpqD7L36jrt0OxrFyz6c35L2WNUbxS094RZzun0U=
Message-ID: <44D3DE48.8060103@gmail.com>
Date: Sat, 05 Aug 2006 01:54:48 +0200
From: RazorBlu <razorblu@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ACLs
References: <44D3BF62.10202@gmail.com> <1154729992.3573.35.camel@brianb> <44D3CFB9.9020208@gmail.com> <F493D385-0915-442A-853A-00B3ED75B8B2@mac.com>
In-Reply-To: <F493D385-0915-442A-853A-00B3ED75B8B2@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> You're quite wrong about SELinux; it _is_ part of the kernel.  
> Admittedly it requires a policy to be built and loaded from userspace, 
> but your "ACLs" would require some ACL utilities to apply those from 
> userspace.
That is true, but is it included in every stable release of the kernel 
(by default)? And why aren't more distributions using it (the popular 
ones - for example, I know Mandriva uses grsecurity).
> In any case SELinux is an extremely powerful model; you can define 
> your arbitrary RBAC+TE state machine and constraints, then the kernel 
> applies it to your system; as simple (or horribly complicated, as the 
> case may be) as that.
And what are your feelings on SELinux still being "under research"? Can 
such a system be used in a production environment, when it has not been 
declared a completely mature system by its creators?
> Here's a better security model:  SELinux lets you give root access to 
> everybody and still have a 100% secure system (although it's not 
> really recommended).  Google around for the public SSH-accessible 
> SELinux testbeds with root's password set to "password" or "1234" or 
> whatever and feel free to log in and have a look.  Besides, we do have 
> POSIX ACLs on files; if that's what you're looking for, but that's not 
> extensible enough to cover processes too.
A 100% secure system except for the files that sshd has access to, 
correct? If global access is allowed to root, but it is locked down to 
sshd, then anyone who logs in as root can only modify those files that 
sshd has access to... Or is there a part of the puzzle that I am 
missing? I had not heard of those testbeds before, but I would like to 
see how they are set up.

"Besides, we do have POSIX ACLs on files; if that's what you're looking 
for, but that's not extensible enough to cover processes too." - Precisely.
> Cheers,
> Kyle Moffett
>
Regards,


RazorBlu
