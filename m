Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbSKERXc>; Tue, 5 Nov 2002 12:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSKERXc>; Tue, 5 Nov 2002 12:23:32 -0500
Received: from almesberger.net ([63.105.73.239]:36873 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S264990AbSKERXV>; Tue, 5 Nov 2002 12:23:21 -0500
Date: Tue, 5 Nov 2002 14:29:43 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: kexec (was: Re: What's left over.)
Message-ID: <20021105142943.I1407@almesberger.net>
References: <20021031020836.E576E2C09F@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031020836.E576E2C09F@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Oct 31, 2002 at 01:07:15PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, let's not forget Eric Biederman's kexec. While not
perfect, it's definitely usable, and looks good enough for
inclusion as an experimental feature.

As to why we need it, I've explained this in my OLS 2000 paper,
sections 2.6 and 5:

http://www.almesberger.net/cv/papers/ols2k-9.ps

My approach was called "bootimg". kexec is similar, but does a few
things related to page sorting/moving better, and it's much smarter
about quiescencing the system before trying to reboot.

I view kexec as an "enabler", much like initrd, which had to be
part of the kernel for a while before people started to figure out
how to use it. (At this year's OLS, somebody told me they just
"discovered" initrd and are now using it. Oh well, it's only been
around for six years ;-)

It should be "experimental", because some compatibility issues
still have to be addressed, but most of this can be done in user
space, and shouldn't require significant changes in the kernel
part of kexec, or in its interface to user space.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
