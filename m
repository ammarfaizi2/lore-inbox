Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUHJJnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUHJJnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUHJJnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:43:24 -0400
Received: from main.gmane.org ([80.91.224.249]:63144 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263740AbUHJJmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:42:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Tue, 10 Aug 2004 11:42:40 +0200
Message-ID: <yw1x7js79vn3.fsf@kth.se>
References: <1092082920.5761.266.camel@cube> <1092124796.1438.3695.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:Tmos1uOau3rq37KhC28pK7SCdWQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> On Mon, 2004-08-09 at 16:22 -0400, Albert Cahalan wrote:
>> Joerg:
>>    "WARNING: Cannot do mlockall(2).\n"
>>    "WARNING: This causes a high risk for buffer underruns.\n"
>> Fixed:
>>    "Warning: You don't have permission to lock memory.\n"
>>    "         If the computer is not idle, the CD may be ruined.\n"
>> 
>> Joerg:
>>    "WARNING: Cannot set priority class parameters priocntl(PC_SETPARMS)\n"
>>    "WARNING: This causes a high risk for buffer underruns.\n"
>> Fixed:
>>    "Warning: You don't have permission to hog the CPU.\n"
>>    "         If the computer is not idle, the CD may be ruined.\n"
>
> That seems reasonable, but _only_ if burnfree is not enabled. If the
> hardware _supports_ burnfree but it's disabled, the warning should also
> recommend turning it on.

I'm also wondering why cdrecord disables it by default.  Can it ever
do any harm being enabled?

-- 
Måns Rullgård
mru@kth.se

