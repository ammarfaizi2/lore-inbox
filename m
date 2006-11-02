Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422967AbWKBBRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422967AbWKBBRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 20:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423096AbWKBBRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 20:17:54 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:37244 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422967AbWKBBRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 20:17:53 -0500
Message-ID: <454945FA.8030901@oracle.com>
Date: Wed, 01 Nov 2006 17:12:26 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Neil Horman <nhorman@tuxdriver.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in several
 drivers
References: <20061023171910.GA23714@hmsreliant.homelinux.net> <20061101161155.d7b30258.randy.dunlap@oracle.com> <20061101162727.72f1183b.akpm@osdl.org> <200611020144.51196.jesper.juhl@gmail.com>
In-Reply-To: <200611020144.51196.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On Thursday 02 November 2006 01:27, Andrew Morton wrote:
>> On Wed, 1 Nov 2006 16:11:55 -0800
>> Randy Dunlap <randy.dunlap@oracle.com> wrote:
>>
>>>> Hmm, I guess that should be defined once and for all in
>>>> Documentation/CodingStyle
>>> I have some other CodingStyle changes to submit, but feel free
>>> to write this one up.
>> Starting labels in column 2 gives me the creeps, personally.  But there's a
>> decent justification for it.
>>
>>> However, I didn't know that we had a known style for this, other
>>> than "not indented so far that it's hidden".
>>>
>>> If a label in column 0 [0-based :] confuses patch, then that's
>>> a reason, I suppose.  I wasn't aware of that one...
>>> In a case like that, we usually say "fix the tool then."
>> The problem is that `diff -p' screws up and displays the label: in the
>> place where it should be displaying the function name.
>>
>> Of course, lots of people forget the -p anyway...  Maybe we can fix those
>> tools ;)
>>
> Until the tools get fixed, how about applying this patch ?
> 
> 
> Add CodngStyle info on labels.
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
> diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
> index 29c1896..f8a3abb 100644
> --- a/Documentation/CodingStyle
> +++ b/Documentation/CodingStyle
> @@ -566,6 +566,18 @@ result.  Typical examples would be funct
>  NULL or the ERR_PTR mechanism to report failure.
>  
>  
> +		Chapter 17: Labels
> +
> +Label names should be lowercase.
> +
> +Label names should start with a letter [a-z].
> +
> +Labels should not be placed at column 0. Doing so confuses some tools, most
> +notably 'diff' and 'patch'. Instead place labels at column 1 (indented 1
> +space). In some cases it's OK to indent labels one or more tabs, but
> +generally it is prefered that labels be placed at column 1.
		~~~~~~~~~~~~
		preferred

I would also say something like this:

Labels should stand out -- be easily visible.  They should not be
indented so much that they are hidden or obscured by the surrounding
source code.



-- 
~Randy
