Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVAOXzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVAOXzh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVAOXzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:55:37 -0500
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:58730 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262368AbVAOXz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:55:29 -0500
Message-ID: <41E9AE73.6020200@sbcglobal.net>
Date: Sat, 15 Jan 2005 15:59:47 -0800
From: Steve <s.egbert@sbcglobal.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050109)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-r1 MTRR bug (
References: <41E595E9.8040805@sbcglobal.net> <20050112230553.683a813b.akpm@osdl.org> <41E84729.1090209@gentoo.org>
In-Reply-To: <41E84729.1090209@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:

> Hi Andrew,
>
> Andrew Morton wrote:
>
>> Steve <s.egbert@sbcglobal.net> wrote:
>>
>>> For the Athlon 2100, I get the following outputs and then the VGA 
>>> console is frozen from further output (but it doesn't prevent the 
>>> full bootup into X windows session of which I am able to resume 
>>> normal Linux/X session, but not able to regain any virtual console 
>>> session.)
>>
>
>>> mtrr: size and base must be multiples of 4kiB  (<<-- this line is 
>>> repeated 20 times).
>>
>>
>>
>> Could you add this so we can track down the culprit?
>
>
> I got another user who reported the same problem to test the patch, 
> the result is:
> http://bugs.gentoo.org/attachment.cgi?id=48451
> (original bug http://bugs.gentoo.org/77674)
>
> I will confirm whether or not this is a gentoo-specific problem or not 
> and let you know.
>
> Daniel
>
Patched + removed VESAFB from config.

The mtrr patch in http://bugs.gentoo.org/show_bug.cgi?id=77674 appears 
to fixes the problem.  No further mtrr debug outputs occurred.   Clean 
boot output now for 2.6.10-r4 + mtrr-debug.patch.

Will try again with VESAFB re-enabled and post further results @ 
bugs.gentoo.org (if any).

THX!

Steve

