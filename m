Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267100AbUBRXSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267096AbUBRXQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:16:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:52967 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267100AbUBRXQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:16:34 -0500
Date: Wed, 18 Feb 2004 15:16:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: tridge@samba.org
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <16435.61622.732939.135127@samba.org>
Message-ID: <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
References: <16433.38038.881005.468116@samba.org> <16433.47753.192288.493315@samba.org>
 <Pine.LNX.4.58.0402170704210.2154@home.osdl.org> <16434.41376.453823.260362@samba.org>
 <c0uj52$3mg$1@terminus.zytor.com> <Pine.LNX.4.58.0402171859570.2686@home.osdl.org>
 <4032D893.9050508@zytor.com> <Pine.LNX.4.58.0402171919240.2686@home.osdl.org>
 <16435.55700.600584.756009@samba.org> <Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
 <Pine.LNX.4.58.0402181427230.2686@home.osdl.org> <16435.60448.70856.791580@samba.org>
 <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004 tridge@samba.org wrote:
> 
>  > Why do you focus on linear directory scans?
> 
> Because a large number of file operations are on filenames that don't
> exist. I have to *prove* they don't exist.

And you only need to do that ONCE per name.

There is zero reason to do it over and over again, and there is zero 
reason to push case insensitivity deep into the filesystem.

Have you checked how many filesystems we have? Hint: 

	ls -l fs/ | grep '^d' | wc

The thing is, you have to realize that Windows-compatibility is very very 
much second-class. If you refuse to realize that, you can't argue 
effectively, because you are arguing for things that simply WILL NOT 
happen.

So instead of having this crazy windows-centric idea, I would suggest you 
try to come up with ways to make it easier for you. I can tell you already 
that it won't be everything you want or need, but quite frankly, your 
choice is between _nada_ and something reasonable.

So give it up. We're not making the same STUPID mistakes that Microsoft 
has done. 

		Linus

