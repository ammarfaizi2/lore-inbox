Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbUKWOS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbUKWOS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUKWOS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:18:29 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:22245 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261259AbUKWORm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:17:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DayerKjIGea4YvCRJIHtP9a30x3qZGKJ996fs2t2kvZSkoF4nRZm7t9J7yghF5ixf6GSPdTsYr2Ozor0rW1jb6apYBwmWdDNMHSTfMU6Op8daaMF5ZlWBrfk35X30J5btbth5TrH6TBYqkF5foLSZ6keSV0tvQ2UPk0G+e1Iq/g=
Message-ID: <2c59f003041123061771ac0efc@mail.gmail.com>
Date: Tue, 23 Nov 2004 19:47:41 +0530
From: Amit Gud <amitgud1@gmail.com>
Reply-To: Amit Gud <amitgud1@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: file as a directory
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0411231458450.28979@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <200411221759.iAMHx7QJ005491@turing-police.cc.vt.edu>
	 <41A23566.6080903@namesys.com>
	 <Pine.LNX.4.53.0411222002380.21595@yvahk01.tjqt.qr>
	 <2c59f00304112301467b411a46@mail.gmail.com>
	 <Pine.LNX.4.53.0411231458450.28979@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004 15:00:37 +0100 (MET), Jan Engelhardt
<jengelh@linux01.gwdg.de> wrote:
> >Correct me if I'm wrong, but the best way I know whether a file should
> >be treated as directory or as a file (atleast how I've implemented it)
> >depends upon the context (how the file is accessed) in the user-space
> >and this context is reflected in the kernel space in the flags of the
> >struct nameidata. So ...
> 
> And there I see a problem! The open() call (kernel: sys_open) allows to open
> both files and directories in the standard operation.
> There is the O_DIRECTORY user-space flag, but which only says "it must be a
> directory". So there's something missing to say "must be a file".
> 
> Hell will freeze over if a reiser4 "object" can be ANY type, blockdev,
> chardev, symlink, <think something up>.
> 

Of course, I check before-hand if the file is archive (.tar, for now).
And then if the appropriate flag is set...treat it as a directory, or
else leave it. Again, if tar format looks as expected, support it or
else leave it.


AG
--
May the source be with you.
