Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTHTIxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTHTIxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:53:23 -0400
Received: from main.gmane.org ([80.91.224.249]:31194 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261775AbTHTIxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:53:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] O17int
Date: Wed, 20 Aug 2003 10:53:21 +0200
Message-ID: <yw1xptj0emm6.fsf@users.sourceforge.net>
References: <200308200102.04155.kernel@kolivas.org> <yw1xbrulxyn8.fsf@users.sourceforge.net>
 <200308201119.41093.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:GD8CELImbaJlJmcV07Jj9PI7HCs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

>> When compiling from xemacs, everything is fine until the compilation
>> is done.  Then xemacs starts spinning wildly in some loop doing this:
>> This goes on for anything from half a second to several seconds.
>> During that time other processes, except X, are starved.
>>
>> I saw this first with 2.6.0-test1 vanilla, then it went away in -test2
>> and -test3, only to show up again with O16.3int.  My O16.2 kernel
>> seems ok, which seems strange to me since the difference from O16.2 to
>> O16.3 is very small.
>
> While being a small patch, 16.2-16.3 was a large change. It removed the very 
> aggressive starvation avoidance of spin on wait waker/wakee in 16.2, which 
> clearly helped your issue.

I have confirmed that this change introduced the problem.

>> Any ideas?
>
> Pretty sure we have another spinner. A reniced -11 batch run of top -d 1 and 
> vmstat during the spinning, and a kernel profile for that time will be 
> helpful.

I'll try to get that.

-- 
Måns Rullgård
mru@users.sf.net

