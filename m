Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTEHOyI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 10:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbTEHOyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 10:54:08 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:29432 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261428AbTEHOyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 10:54:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: The disappearing sys_call_table export.
Date: Thu, 8 May 2003 09:56:49 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
References: <200305081009_MC3-1-37FA-2408@compuserve.com>
In-Reply-To: <200305081009_MC3-1-37FA-2408@compuserve.com>
MIME-Version: 1.0
Message-Id: <03050809564900.09057@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 May 2003 09:08, Chuck Ebbert wrote:
> Al Viro wrote:
> >> > I'd make a stab at it if I knew that it stood a chance of getting
> >> > accepted.
> >>
> >> I dont think it has.
> >
> > I think it could, actually - who maintains fortunes these days?  It's
> > a bit too long, though...
>
>   Wow, Advanced Sarcasm.  Must be part of the Graduate program...
>
>   Meanwhile on Win2k I can intercept any IO request by
> wrting a filter driver, and that driver can get control on the way
> back to userspace by registering a completion routine.  Such filters
> can be arbitrarily chained together and can be placed either above or
> below an FSD, making such things as virus detection, HSM and disk
> mirroring much easier to write...

note the key word in the phrase "filter DRIVER". Linux modules can intercep
any I/O directed toward them. and the filesystem layer can intercept any
filesystem call. And there are filesystem modules.

M$ seems to treat everything as a disk file (even "pipes" are implemented
as temporary files).

Have you tried catching the display IO ???

HSM has existed on UNIX based machines for a long time.

>   How would I do this on Linux?  How would virus detection and HSM
> coexist?  (HSM would have to be 'above' the virus detector, since it
> makes no sense to try and scan a file that's been migrated until it
> gets recalled back to disk.)

I would expect the same way the NFS module interceps file system calls.

There is NO reason a custom filesystem cannot be layered over other 
filesystems. It might not be done today (though the references to "userfs"
keep showing up in such discussions).

I do question the validity of virus detection though. Once examined, fix the
vulnerability. No more virus.

Virus detection can never be completely done. And it imposes a constantly 
increasing overhead since you must be able to identify all pre-existing 
viruses. This list of "pre-existing" will be constantly growing.

Fix the vulnerability. Then there won't be a virus.
