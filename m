Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVBUQop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVBUQop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 11:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVBUQop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 11:44:45 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:41197 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262034AbVBUQol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 11:44:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pGEoRUHniS3pRQc+tWzZvcfq1l1Ne7ZJAYG1kf8m1UMYfssewD26I1wOmCuCKByLbkOkt2eLpbG05xJm+o8fViKB50ijUumT+01Xw5OseDjdelql+OSTuM15/7pFdDkwPujvrxYR/aprY41jvqvYOlxaSeVuoW8Xne1A3+qAm2c=
Message-ID: <93ca30670502210844578dce95@mail.gmail.com>
Date: Mon, 21 Feb 2005 10:44:38 -0600
From: Alex Adriaanse <alex.adriaanse@gmail.com>
Reply-To: Alex Adriaanse <alex.adriaanse@gmail.com>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: Odd data corruption problem with LVM/ReiserFS
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <4219C811.5070906@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <93ca3067050220212518d94666@mail.gmail.com>
	 <4219C811.5070906@domdv.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 12:37:53 +0100, Andreas Steinmetz <ast@domdv.de> wrote:
> Alex Adriaanse wrote:
> > As far as I can tell all the directories are still intact, but there
> > was a good number of files that had been corrupted.  Those files
> > looked like they had some chunks removed, and some had a bunch of NUL
> > characters (in blocks of 4096 characters).  Some files even had chunks
> > of other files inside of them!
> 
> I can second that. I had the same experience this weekend on a
> md/dm/reiserfs setup. The funny thing is that e.g. find reports I/O
> errors but if you then run tar on the tree you eventually get the
> correct data from tar. Then run find again and you'll again get I/O errors.
The weird thing is I did not see any I/O errors in my logs, and
running find on /var worked without a problem.  By the way, did you
take any DM snapshots when you experienced that corruption?
