Return-Path: <linux-kernel-owner+w=401wt.eu-S1763025AbWLKTmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763025AbWLKTmE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763029AbWLKTmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:42:04 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:33867 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763025AbWLKTmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:42:02 -0500
Date: Mon, 11 Dec 2006 20:34:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Olaf Hering <olaf@aepfle.de>, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
In-Reply-To: <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
Message-ID: <Pine.LNX.4.61.0612112033030.28981@yvahk01.tjqt.qr>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de>
 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 11 2006 08:44, Linus Torvalds wrote:
>> 
>> Please revert this change.
>
>Well, that "get_kernel_version" is definitely buggered, and should be 
>fixed. And we do want the new behaviour for /proc/version.
>
>So I don't think we should revert it, but we should:
>
> - strongly encourage "get_kernel_version" users to just stop using that 
>   crap. Ask the build system for the version instead or something, don't 
>   expect to dig it out of the binary (if you create an RPM for any other 
>   package, you sure as _hell_ don't start doing strings on the binary and 
>   try to figure out what the kernel is - you do it as part of the build)
>
>What crud. I'm even slightly inclined to just let SLES9 be broken, just to 
>let people know how unacceptable it is to look for strings in kernel 
>binaries. But sadly, I don't think the poor users should be penalized for 
>some idiotic SLES developers bad taste.


If you fix it now, it will anyhow only be fixed for >= 2.6.20, hence
you don't break current/older SLES kernel builds.


	-`J'
-- 
