Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbTHTJTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 05:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTHTJTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 05:19:11 -0400
Received: from main.gmane.org ([80.91.224.249]:40666 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261829AbTHTJTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 05:19:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] O17int
Date: Wed, 20 Aug 2003 11:19:08 +0200
Message-ID: <yw1xlltoelf7.fsf@users.sourceforge.net>
References: <200308200102.04155.kernel@kolivas.org> <yw1xn0e5lhz9.fsf@users.sourceforge.net>
 <200308201123.29206.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:Jm3XaCFKDuwOe7x+zIjOrWOCPWw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

>> > This patch prevents any single task from being able to starve the
>> > runqueue that it's on. This minimises the impact a poorly behaved
>> > application or a malicious one has on the rest of the system. If an
>>
>> I have to disagree.  Open a file of a few hundred lines in XEmacs and
>> do a regexp search for "^[> ]*-*\n\\([> ]*.*\n\\)*[> ]*foo".  The
>> system will more or less freeze.  It's a very nasty regexp, and it's
>> an error to try to use it, but it still shouldn't freeze the system.
>
> Reasonably sure this is a variation on the starvation which O17
> won't address.

Well, obviously.

I tried O17 minus 016.2-O16.3, and I don't get the problems, even with
X at nice 0.  Does that tell you anything.

> Please top/vmstat/profile this and I'll look into it. There is
> potential for starvation without using up full timeslices and this
> may be it.

I'll do when I boot a kernel that has the problem.

-- 
Måns Rullgård
mru@users.sf.net

