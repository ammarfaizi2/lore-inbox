Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbREMGS2>; Sun, 13 May 2001 02:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261380AbREMGSJ>; Sun, 13 May 2001 02:18:09 -0400
Received: from cx595243-c.okc1.ok.home.com ([24.6.27.53]:52867 "EHLO
	quark.localdomain") by vger.kernel.org with ESMTP
	id <S261379AbREMGRu>; Sun, 13 May 2001 02:17:50 -0400
From: Vincent Stemen <linuxkernel@AdvancedResearch.org>
Date: Sun, 13 May 2001 01:17:37 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: jq419@my-deja.com (Jacky Liu), linux-kernel@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E14yHw8-0001V8-00@the-village.bc.nu>
In-Reply-To: <E14yHw8-0001V8-00@the-village.bc.nu>
Subject: Re: 2.4.4 kernel freeze for unknown reason
MIME-Version: 1.0
Message-Id: <01051301173700.02739@quark>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 May 2001 13:46, Alan Cox wrote:
> > I have been monitoring the memory usage constantly with the gnome
> > memory usage meter and noticed that as swap grows it is never freed
> > back up.  I can kill off most of the large applications, such as
>
> The swap handling in 2.4 is somewhat hosed at the moment.
>
> > If I turn swap off all together or turn it off and back on
> > periodically to clear the swap before it gets full, I do not seem to
> > experience the lockups.
>
> That sounds right. I can give you a tiny patch that should fix the
> lockups and instead it will kill processes out of memory but thats
> obviously not the actual fix 8)

I am not sure if you got my reply to this Alan, but I would like to
have you send me the patch.  Thanks.

Also, I got to thinking back and it dawned on me that there was
another significant kernel change when we started experiencing the
freezes from the vm problems.  We changed the compiler from
gcc-2.7.2.3 to egcs-1.1.2 starting with kernel 2.4.0-test10 (That is
the version in which gcc-2.7.2.3 stopped being supported for the
kernel) and it seems like that was just about the same time frame that
we started experiencing the vm/swap problems.  I would have to go back
and run on the test10 kernel for a while to confirm if it started with
it or 2.4.0.

I am assuming the source of the vm problem is still unknown or it
would have been fixed by now.  Is it possible that it could be related
to the compiler change?  If nobody has considered that, I just thought
I would bring the possibility to your attention.  

- Vincent Stemen
