Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291197AbSAaRrf>; Thu, 31 Jan 2002 12:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291198AbSAaRrZ>; Thu, 31 Jan 2002 12:47:25 -0500
Received: from 216-42-72-173.ppp.netsville.net ([216.42.72.173]:19652 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S291197AbSAaRrQ>; Thu, 31 Jan 2002 12:47:16 -0500
Date: Thu, 31 Jan 2002 12:45:44 -0500
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>, Dave Jones <davej@suse.de>,
        "Sebastian Dr?ge" <sebastian.droege@gmx.de>,
        linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <4233320000.1012499144@tiny>
In-Reply-To: <20020131194401.A818@namesys.com>
In-Reply-To: <20020130173715.B2179@namesys.com> <20020130163951.13daca94.sebastian.droege@gmx.de> <20020130190905.A820@namesys.com> <20020130174011.L24012@suse.de> <20020130201054.6e150f78.sebastian.droege@gmx.de> <20020130201757.Q24012@suse.de> <20020131122424.A874@namesys.com> <20020131134931.A5948@suse.de> <20020131155325.A3629@namesys.com> <20020131141101.B5948@suse.de> <20020131194401.A818@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, January 31, 2002 07:44:01 PM +0300 Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Thu, Jan 31, 2002 at 02:11:01PM +0100, Dave Jones wrote:
> 
>    Ok, I think we got it. And yes it it was reiserfs fault.
>    What I really cannot understand is how it was working before???
> 
>    Ok, so anybody who sees the oopses should try 2 patches attached.
>    prealloc_init_list_head.diff is just forgotten initialisation
>    and pick_correct_key_version.diff is the real fix.
> 
>    I wonder is anybody will be able to reproduce a bug with these 2 fixes
>    (I hope not).
> 
>    Chris: Can you also take a look?

Both fixes look right.  I'm a little worried about 
pick_correct_key_version.diff, that bug looks like it could get the keys 
into the tree in the wrong order.  We need to reproduce it with an
unpatched kernel, and then apply the fix to make sure the sky doesn't
fall on us.

-chris

