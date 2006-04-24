Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWDXNoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWDXNoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWDXNoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:44:44 -0400
Received: from stanford.columbia.tresys.com ([209.60.7.66]:10715 "EHLO
	gotham.columbia.tresys.com") by vger.kernel.org with ESMTP
	id S1750809AbWDXNon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:44:43 -0400
Message-ID: <444CD5FD.2040102@gentoo.org>
Date: Mon, 24 Apr 2006 09:43:25 -0400
From: Joshua Brindle <method@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: "Theodore Ts'o" <tytso@mit.edu>, Neil Brown <neilb@suse.de>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de> <1145522524.3023.12.camel@laptopd505.fenrus.org> <20060420192717.GA3828@sorel.sous-sol.org> <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil> <20060421173008.GB3061@sorel.sous-sol.org> <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil> <17484.20906.122444.964025@cse.unsw.edu.au> <20060424070324.GA14720@thunk.org> <20060424130406.GA1884@elf.ucw.cz>
In-Reply-To: <20060424130406.GA1884@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0616-4, 04/21/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> In the security world, there is a huge tradition of the best being the
>> enemy of the good --- and the best being so painful to use that people
>> don't want to use it, or the moment it gets in the way (either because
>> of performance reasons or their application does something that
>> requires painful configuration of the SELinux policy files), they
>> deconfigure it.  At which point the "best" becomes useless.
>>
>> You may or may not agree with the philosophical architecture question,
>> but that doesn't necessarily make it "broken by design".  Choice is
>> good; if AppArmor forces SELinux to become less painful to use and
>> configure, then that in the long run will be a good thing.
>>     
>
> SELinux kernel support can _almost_ do what AA does; with notable
> exception of labels for new files. That can probably be fixed with
> patch of reasonable size (or maybe even with LD_PRELOAD library, glibc
> modification, or stuff like that). (There was post showing that in
> this long flamewar).
>   
New file labels based on path should not be addressed in the kernel and 
LD_PRELOAD would be incredibly hacky. Our solution to the problem is 
restorecond (http://danwalsh.livejournal.com/4368.html) which addresses 
users who want to be able to mkdir public_html and immediately use it. 
Userland solutions like this will make SELinux easier and easier to use, 
and they already have. Anyone not keeping up with SELinux lately a 
tremendous amount has been done in the area of usability as outlined at 
this years selinux symposium 
(http://selinux-symposium.org/2006/slides/01-smalley-yir.pdf).


Joshua
