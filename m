Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263888AbUDVJky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263888AbUDVJky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 05:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263889AbUDVJky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 05:40:54 -0400
Received: from smtpout.mac.com ([17.250.248.46]:64218 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S263888AbUDVJkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 05:40:53 -0400
Message-ID: <2899705.1082626850875.JavaMail.pwaechtler@mac.com>
Date: Thu, 22 Apr 2004 11:40:50 +0200
From: Peter Waechtler <pwaechtler@mac.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] coredump - as root not only if euid switched
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
On Thursday, April 22, 2004, at 10:55AM, Andrew Morton <akpm@osdl.org> wrote:

>Peter Waechtler <pwaechtler@mac.com> wrote:
>>
>>  But I agree that sys_unlink should be the fast call and dumping core
>>  is the exception :)
>> 
>>  would fastcall do_unlink() help? I guess the arg is then passed in a
>>  register
>
>I've never been able to measure any size or space benefit for fastcall, and
>we do it via compiler options kernel-wide nowadays.
>
>The above will work fine.  You can probably just open-code it at the place
>where you're unlinking the file.
>
>(why are you trying to unlink the old file anyway?)
>

For security measure :O
I tried on solaris: touch the core file as user, open it and wait, dump core
as root -> nope, couldn't read the damn core - it was unlinked and created!
So do I want.
I will sent the new patch from home.

