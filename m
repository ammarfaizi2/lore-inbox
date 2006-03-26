Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWCZMT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWCZMT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWCZMT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:19:26 -0500
Received: from main.gmane.org ([80.91.229.2]:64721 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750717AbWCZMTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:19:25 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Parenthesize macros in xfs
Date: Sun, 26 Mar 2006 13:19:14 +0100
Message-ID: <yw1x3bh5xut9.fsf@agrajag.inprovide.com>
References: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr> <20060321082327.B653275@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0603202239110.11933@yvahk01.tjqt.qr> <20060321084619.E653275@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0603252232570.18484@yvahk01.tjqt.qr> <je1wwq2lqn.fsf@sykes.suse.de> <Pine.LNX.4.61.0603260023070.12891@yvahk01.tjqt.qr> <jewtei1434.fsf@sykes.suse.de> <Pine.LNX.4.61.0603261124320.22145@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:LgiBS3+51GGIT2fj7VxiAS5L4aA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>>>> +		swapfunc(a, b, es, swaptype)		\
>>>>> +} while(0)
>>>>                                           ^^
>>>>Missing semicolon.
>>>
>>> It was missing before too. ;)
>>
>>No, previously it was provided at the call site.
>
> Bad habit IMO. It does not hurt to provide it in both the macro and 
> the call site, GCC can handle empty instructions.

A double semicolon can cause all sorts of hard to debug problems.
Consider this:

#define foo() bar();
/* ... */
if(x)
    foo();
else
    baz();

This will expand to syntactically invalid code because of the extra
semicolon.

-- 
Måns Rullgård
mru@inprovide.com

