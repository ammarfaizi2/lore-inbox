Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWBUWCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWBUWCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWBUWCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:02:11 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:7081 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964866AbWBUWCK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:02:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q+8OdRvMVnO7KlQ6f3u7pIU8k2FBYCOc7MKO6D2k9F3YFXPAOEeiKmJFv9WCHJy+yEeG8wo44oGxMSfb7rSDEw/x0QsPGKZ+96RBvycNVwyP8e+oDBGqpqnrEWJPmIky6wK73p2CNHhQzYAqAuhhIHJa1ov8xn00l7soZ0w7xTs=
Message-ID: <9a8748490602211402m7ab61633n3aa7ded63fa7bdcd@mail.gmail.com>
Date: Tue, 21 Feb 2006 23:02:09 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Paul Fulghum" <paulkf@microgate.com>
Subject: Re: make -j with j <= 4 seems to only load a single CPU core
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Sam Ravnborg" <sam@ravnborg.org>, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1140558161.9838.8.camel@amdx2.microgate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490602211302j61c0088fp8b555860e928028e@mail.gmail.com>
	 <9a8748490602211310j344db10evd685149a3c60b1e7@mail.gmail.com>
	 <1140558161.9838.8.camel@amdx2.microgate.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Paul Fulghum <paulkf@microgate.com> wrote:
> On Tue, 2006-02-21 at 22:10 +0100, Jesper Juhl wrote:
>
> > I should probably mention that the kernel I'm currently running and
> > observing this behaviour with is 2.6.16-rc4-mm1.
> ...
> > > I find this quite strange since anything from 'make -j 2' and up
> > > should be able to keep both cores resonably busy, but there seems to
> > > be a huge difference between j <= 4 and j > 4.
>
> I've seen the same thing (on Athlon 64x2 64 bit)
> but was not sure if it was a problem.
>
> The break point for me seems to be between -j 2 and -j 3

That's the break point for me as well when I'm not using 'nice'. When
I use 'nice' the break point moves to -j 4/5 .

> -j 2 = serialized (or the appearance of)
> -j 3 = both cores mostly busy
>
> I'm pretty sure with an earlier 2.6 kernel source (but same environment)
> I did not see this. I'll start back tracking to earlier kernels
> to see if I can identify when this started.
>

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
