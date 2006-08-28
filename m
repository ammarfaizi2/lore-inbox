Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWH1KKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWH1KKr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 06:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWH1KKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 06:10:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:59728 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964777AbWH1KKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 06:10:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fh0pTLiIoaoHYWZOwT0KEQ95wGphgqtzaJB3h0LRlCfsk3HrVFxu5IaxxrDStp9OMRxdd5nWzpOIAx2sIhWdkXP6yNnVfbCVQrwPXb/yH1PhG3gd9iM8dJsRLXn3TFC1ohkhC0KI6yrauro+yBBrn8yq+ScklxikrNdggvk1xdQ=
Message-ID: <9a8748490608280310q65c1335cr2603b044c340a489@mail.gmail.com>
Date: Mon, 28 Aug 2006 12:10:45 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Linux v2.6.18-rc5
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Nathan Scott" <nathans@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> Ok,
>  this was delayed three weeks due to a combination of vacations and a
> funeral in Finland, but Greg and Andrew kept on top of things, and we were
> fairly late in the release cycle anyway, so it hopefully caused no real
> problems apart from obviously delaying the final release a tiny bit.
>
> Linux 2.6.18-rc5 is out there now, both in git form and as patches and
> tar-balls (the latter which I forgot for -rc4, but Greg covered for me -
> blush).
>
> The shortlog (appended) tells the story: various fixes all around.
> Powerpc, V4L, networking, SCSI..
>
> Pls test it out, and please remind all the appropriate people about any
> regressions you find (including any found earlier if they haven't been
> addressed yet).
>
Not really a regression, more like a long standing bug, but XFS has
issues in 2.6.18-rc* (and earlier kernels, at least post 2.6.11).
With heavy rsync load to a machine with XFS filesystems, XFS falls
over and filesystems are in need of xfs_repair.
I'm doing all I can to gather info for Nathan so he can fix the bug,
but it's hard to trigger reliably.
My point is that perhaps it's worth delaying 2.6.18 a little longer in
the hope of getting that bug fixed before release. Nathan?
At least for me, XFS in its current state (and thus 2.6.18)  is
unusable in production environments.

See the thread titled "2.6.18-rc3-git3 - XFS - BUG: unable to handle
kernel NULL pointer dereference at virtual address 00000078" for the
full story.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
