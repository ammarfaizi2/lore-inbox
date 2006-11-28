Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758690AbWK1Pkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758690AbWK1Pkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 10:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758691AbWK1Pkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 10:40:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15338 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1758690AbWK1Pko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 10:40:44 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix the binary ipc and uts namespace sysctls.
References: <m1hcwlmqmp.fsf@ebiederm.dsl.xmission.com>
	<20061127202211.GB26108@MAIL.13thfloor.at>
	<m1y7pwldi4.fsf@ebiederm.dsl.xmission.com>
	<20061128143250.GA23131@MAIL.13thfloor.at>
Date: Tue, 28 Nov 2006 08:38:25 -0700
In-Reply-To: <20061128143250.GA23131@MAIL.13thfloor.at> (Herbert Poetzl's
	message of "Tue, 28 Nov 2006 15:32:50 +0100")
Message-ID: <m1y7pvinta.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> On Mon, Nov 27, 2006 at 03:40:35PM -0700, Eric W. Biederman wrote:
>> Herbert Poetzl <herbert@13thfloor.at> writes:
>> 
>> > the linux banner needs some attention too, when I get
>> > around, I'll send a patch for that ...
>> 
>> In what sense?
>> 
>> I have trouble seeing the banner printed at bootup as being problematic.
>
> was it removed from procfs after 2.6.19-rc6
> (/proc/version  sorry, haven't checked yet)

I see where you are coming from.  Yes that is a potential issue,
because ultimately that information is utsname information.  Given
that we don't allow any of that information to be changed currently
that isn't a 2.6.19 issue. 

Given that it is a don't care as long as we generate the same string
I don't see a problem with a patch to modify it, to track changes in
the current uts namespace.

Eric
