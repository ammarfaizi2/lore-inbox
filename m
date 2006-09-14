Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWINHMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWINHMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWINHMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:12:15 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:13889 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751376AbWINHMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:12:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uNaHya6Jvhx5rxQhYbhVqMTh6BziqeRnpxFObvwMdG1QHK+4cw48BaBgPFMAlihxvprYI0esGmRTX7ENaCaB0zf8zOKg5+kEihvTGgZVZiaGel3zkU+6+UvDQZjZ+I2BcDm8OdOJ3VRf2a427zi0enggOPOqvl7abcwU8W5h/A8=
Message-ID: <787b0d920609140012i220a189es68d077f3c67c68e2@mail.gmail.com>
Date: Thu, 14 Sep 2006 03:12:14 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Zachary Amsden" <zach@vmware.com>
Subject: Re: Assignment of GDT entries
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, torvalds@osdl.org,
       jeremy@goop.org, mingo@elte.hu, ak@suse.de, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4508F680.8030501@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920609132106p492cc990na471484d7dee8afb@mail.gmail.com>
	 <m11wqf12hh.fsf@ebiederm.dsl.xmission.com>
	 <787b0d920609132319y660c62c5rc245843aa55fd615@mail.gmail.com>
	 <4508F680.8030501@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/06, Zachary Amsden <zach@vmware.com> wrote:
> Albert Cahalan wrote:

> > So basically it's not allowed to just grab the 3rd slot?
>
> You can, but you should be prepared for it to fail as well.

Without knowing details of the kernel's GDT, how?

> > What if I want to find out what is already in use?
> > Am I supposed to iterate over all 8191 possible
> > GDT entries? How do I even tell how many slots
> > are available without using them all up?
>
> There are only 32 possible GDT entries in 32-bit i386 Linux, and only
> three of them are usable for userspace.  You can't find out which slots
> are in use, but you can cause one to be allocated and returned to you.
> This seems like a perfectly reasonable API to me, why do you think it is
> so ugly?

Eh, "returned to you" doesn't work for me. I need to
figure out what other code (not written by me) uses.

I may need to "borrow" a slot if all three slots are in
use. Without using evil knowledge of the GDT, how
am I to do that? I don't know what slots might have
been allocated by other libraries.
