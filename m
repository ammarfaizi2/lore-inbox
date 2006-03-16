Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWCPWBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWCPWBZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWCPWBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:01:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12006 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964857AbWCPWBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:01:24 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       janak@us.ibm.com, viro@ftp.linux.org.uk, hch@lst.de,
       mtk-manpages@gmx.net, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before we
 are committed.
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>
	<20060316123341.0f55fd07.akpm@osdl.org>
	<Pine.LNX.4.64.0603161240330.3618@g5.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 16 Mar 2006 14:58:29 -0700
In-Reply-To: <Pine.LNX.4.64.0603161240330.3618@g5.osdl.org> (Linus
 Torvalds's message of "Thu, 16 Mar 2006 12:41:30 -0800 (PST)")
Message-ID: <m1d5gm6ohm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 16 Mar 2006, Andrew Morton wrote:
>> 
>> iirc there was some discussion about this and it was explicitly decided to
>> keep the CLONE flags.
>> 
>> Maybe Janak or Linus can comment?
>
> My personal opinion is that having a different set of flags is more 
> confusing and likely to result in problems later than having the same 
> ones. Regardless, I'm not touching this for 2.6.16 any more, 

I am actually a lot more concerned with the fact that we don't test
for invalid bits.  So we have an ABI that will change in the future,
and that doesn't allow us to have a program that runs on old and new
kernels.

I guess I can resend some version of my patch after 2.6.16 is out and
break the ABI for the undefined bits then.  Correct programs shouldn't
care.  But it sure would be nice if they could care.

Eric
