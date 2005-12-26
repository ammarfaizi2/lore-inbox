Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVLZMsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVLZMsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 07:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVLZMsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 07:48:08 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:33331 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750717AbVLZMsH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 07:48:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PL7xuiDWpmcgqnTRTdgXgg/CoYEuylSfRQkKuFPtotWJoLSTuVK1XUICFQ91xddCyopStjkg+5s3VvfRT9zBOwMuupstpJFA9Fg8tlThFVgfH4LHHMw29bZ8pIsgiQDl58VRUsofXYpDNZ0LxZL7F+OLJ+dfeZmEO2OO/A80nqo=
Message-ID: <84144f020512260448w119fa376uea3bf985c35a70a6@mail.gmail.com>
Date: Mon, 26 Dec 2005 14:48:05 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Tarkan Erimer <tarkane@gmail.com>
Subject: Re: [BUG]: Hard lockups continue with linux-2.6.15-rc1-rc7
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9611fa230512260357gcb3a163tae35f7e69f1ee7df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9611fa230512260357gcb3a163tae35f7e69f1ee7df@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tarkan,

On 12/26/05, Tarkan Erimer <tarkane@gmail.com> wrote:
> I'm having hard lockups with all the RCs of linux-2.6.15. I,
> previously, mentioned this with the subject "[BUG]: Software compiling
> occasionlly hangs under 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2" in the
> list. I investigated a bit at found these interesting things.
>
> -- Always reproducable. To reproduce:
>     - in console 1, issueing "updatedb"
>     - in console 2, issueing "find / -name "blahblah" -print
>     - in console 3, issueing "emerge -uDp world" (BTW, I'm using Gentoo.)
>     - in console 4, X started.
>     - a few minutes later, system completely freezes. No Alt+SysRq+t
> works. (Normally, it does)
>
> When the system freezes, there is nothing in logs. But hardly, I
> captured an  Alt+SysRq+t. A few seconds (15-20 seconds) before hang. I
> attached this  Alt+SysRq+t and lsmod output. Hope this helps to solve
> this.

You can use git bisect to narrow down the changeset that introduced
the bug. Please refer to the following URL for details:
http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt

                        Pekka
