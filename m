Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTK1KrY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 05:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTK1KrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 05:47:24 -0500
Received: from main.gmane.org ([80.91.224.249]:19879 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262114AbTK1KrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 05:47:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Strange behavior observed w.r.t 'su' command
Date: Fri, 28 Nov 2003 11:47:20 +0100
Message-ID: <yw1x65h43h3b.fsf@kth.se>
References: <3FC707B6.1070704@mailandnews.com> <jeoeuw7pf7.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:7CGs1Sg1TBF141h/5tD+Ig1iP9Y=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

>> hi, i am not sure if this is a kernel problem or an 'su' related issue,
>> but this is what  i have observed. Tried on 2.4.20-8 ( RH 9.0 kernel ) and
>> latest 2.6.0-test11.
>>
>> - log in as any normal user. ( on Console.).
>> - su - root
>> - from root prompt, run 'ps' and check the pid of 'su'.
>> - kill -9 <pid of su>
>> After the kill command, strangely my keyboard switches to unbuffered mode
>> ( a key press is processed immediately ). Also, i alternate between the
>> root prompt and the normal user prompt.
>> Every key press switches from root prompt to normal user prompt and vice
>> versa. Typing 'whoami' at the respective prompts displays 'normal user'
>> and 'root' for the respective prompts.
>
> Nothing unusual, you just have two shells competing with each other on the
> terminal.  Don't use kill -9 unless you know what you are doing.

It appears that my su exec()s the shell, whereas the redhat and gentoo
su fork() and exec().

-- 
Måns Rullgård
mru@kth.se

