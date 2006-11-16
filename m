Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424653AbWKPVaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424653AbWKPVaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424638AbWKPVaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:30:06 -0500
Received: from nz-out-0102.google.com ([64.233.162.207]:3019 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1424654AbWKPVaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:30:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qZW/Ho/1X/qoBbnGbYRkKTn1ysiQiSTbWK4RKUeFFEDLpdybxfDo+iyR5Ez0N/uY1dfSK2fcKzPWXjRveweb2/f2iBPB6hwEKvAJGbOlOaqVbOhEKwX0ee6SJZ9+iA4gF1xp4+91PVb0T+ZxW3hNvYzmf47MhEsbdlW5uNaXuVQ=
Message-ID: <9a8748490611161330k124e34a5s8ede7df810d7bbc4@mail.gmail.com>
Date: Thu, 16 Nov 2006 22:30:03 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: How to go about debuging a system lockup?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061116212140.GP8236@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061116153444.GC8238@csclub.uwaterloo.ca>
	 <9a8748490611161249t406768beqeaff0fc31f96e8df@mail.gmail.com>
	 <20061116212140.GP8236@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/06, Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> On Thu, Nov 16, 2006 at 09:49:06PM +0100, Jesper Juhl wrote:
...
> > - You could also try kdb (http://oss.sgi.com/projects/kdb/) or kgdb
> > (http://kgdb.linsyssoft.com/). That might help you pinpoint the
> > failure.
>
> Can I run that remotely somehow?  I never really looked at kdb or kgdb
> before.
>
Yes you can. kgdb is run on a separate machine from the one you are debugging.

> > - If you have (or can identify) an older, working, kernel version and
> > you are confident that you can reproduce the problem reliably, then
> > doing a git bisection search starting with your newest "known good"
> > and oldest "known bad" kernel versions, should help you pinpoint the
> > commit causing the breakage.
>
> I don't know of a good version yet.  I so far don't know if there ever
> was one.  This could even be a bug in the PCI hardware, or the way the
> BIOS on this system on a board configured the PCI controller.  Maybe I
> should go back and try a 2.4 kernel.
>
Or just try a few random older 2.6 kernels like 2.6.14, 2.6.9,
2.6.whatever (of course it needs to be a version that git knows
about).


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
