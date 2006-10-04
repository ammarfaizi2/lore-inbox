Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWJDRaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWJDRaw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWJDRav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:30:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:17480 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964900AbWJDRav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:30:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sZ5E9R3ZYhFfnD6fa5DC4MtgHwfRRwhT0zTkShmbhPM7UO+mBc9kROESHSg0UEqEWploLhcsleARRxpowABK7wFNVdqwmcnY0S3Z2JkOSz2OBpLv81zvEGbIlGF8jWdJdO5p1tYj105j+DTl71SUG4335c19VB4QoYrN1sWItCg=
Message-ID: <a36005b50610041030k1ca54065v90a5f6d54b5b9254@mail.gmail.com>
Date: Wed, 4 Oct 2006 10:30:48 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "David Wagner" <daw-usenet@taverner.cs.berkeley.edu>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <efvcs7$526$1@taverner.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45150CD7.4010708@aknet.ru> <4522B7CD.4040206@redhat.com>
	 <efv8pc$31o$1@taverner.cs.berkeley.edu>
	 <a36005b50610032051h64609d51kf1e5211d1bf07370@mail.gmail.com>
	 <efvcs7$526$1@taverner.cs.berkeley.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/06, David Wagner <daw@cs.berkeley.edu> wrote:
> I wonder whether it is feasible to run with allow_exec{heap,mem,mod,stack}
> all set to false, on a real system.  Is there any example of a fully
> worked out SELinux policy that has these set to false?  FC5 has
> allow_execheap set to false and all others set to true in its default
> SELinux policy,

This is the default setting to minimize breakage.  And it has been set
like this (in the FC6 devel cycle) only in the last minute.  For most
of the devel cycle all were off.  For the distribution as a hole there
is simply too much of a chance for something to break and make the
system appear unusable.  This is mostly code in 3rd party apps.
Reason enough, unfortunately, for us to default on the safe side.

But I run my machines with everything turned off.  We cleaned up the
code we ship so that this is possible.
