Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWBUVv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWBUVv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWBUVv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:51:26 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:48199 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932167AbWBUVv0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:51:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e3AzIthycm0Uo5W3WbbZbjlliavzhz1ijLPgLIX+6ak3YaxyZdJ/Anr/tQla/jfLRcpDTZdhM75qCEts+8sJcrMkIVCZLMwmdW5r/g+bXghJtFnYfrCB4WYJHe4d8HE36Eukz3BBbszbYkpsOTC2hZfPBZDLYdSZWZTTyWup++c=
Message-ID: <9a8748490602211351v29c7804ew3a1305326941ea84@mail.gmail.com>
Date: Tue, 21 Feb 2006 22:51:24 +0100
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
> -j 2 = serialized (or the appearance of)
> -j 3 = both cores mostly busy
>
> I'm pretty sure with an earlier 2.6 kernel source (but same environment)
> I did not see this. I'll start back tracking to earlier kernels
> to see if I can identify when this started.
>

I know positively that I've seen this with previous 2.6.16-<something>
kernels, but not sure which ones exactely. I just dismissed it as
something that would probably be fixed soon and then today when I
build a few test kernels I noticed it again and thought "ohh, so it
didn't get fixed, better report it".

I don't recall seeing it with 2.6.15 and earlier kernels, but I'm not
at all sure - especially since I only got this Athlon X2 box recently
and the first kernels I ever ran on it were 2.6.15-<something>.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
