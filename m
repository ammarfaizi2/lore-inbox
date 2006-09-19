Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751982AbWISArg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbWISArg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 20:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbWISArg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 20:47:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:30396 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751982AbWISArf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 20:47:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q6UFPeKbnOML787Zk/SXzgYVwNy1pSu3YSaYPYAaag2kIWKYS9YrCckhtyhiETXjjJs8xm6by5mbuhl4wBkWzHAkg1R3VBAgU1FmnIEOfZt4VUPbT1DbBLvR1OQN43AUHXWORPw9AjHgE7PcwthTbTbV+/hyDcnQNjTETybes80=
Message-ID: <9a8748490609181747i9da3107q593ab99ced48bced@mail.gmail.com>
Date: Tue, 19 Sep 2006 02:47:34 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Math-emu kills the kernel on Athlon64 X2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       billm@melbpc.org.au, billm@suburbia.net
In-Reply-To: <Pine.LNX.4.64.0609181642200.4388@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <Pine.LNX.4.64.0609181549200.4388@g5.osdl.org>
	 <9a8748490609181614r55178f1djab68eb48bd36f7de@mail.gmail.com>
	 <Pine.LNX.4.64.0609181642200.4388@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/06, Linus Torvalds <torvalds@osdl.org> wrote:
[...]
>
> You can try booting with "no387 nofxsr" to get rid of at least _that_
> particular issue, but there might be other cases like that in the MMX
> code, for example ("nofxsr" should disable both the FXSR and XMM
> capabilities as far as the kernel is concerned).
>
> If that works (or gets you further), we should just make "no387" disable
> FXSR by itself.
>
> Worth testing, and you can do it without even recompiling the kernel,
> since we already have that kernel command line flag.
>

Booting with: vga=normal no387 nofxsr
gets me no forther.   These are all the messages I get:

 boot: 2.6.18rc7git2 vga=normal no387 nofxsr
 Loading 2.6.18rc7git2...................................
 BIOS data check successful
 Uncompressing Linux... Ok, booting the kernel.

And then the system hangs and requires a power cycle.

So unfortunately that does't help much :-(


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
