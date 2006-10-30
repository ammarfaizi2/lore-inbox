Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030567AbWJ3Rd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030567AbWJ3Rd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030566AbWJ3Rd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:33:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:36221 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030564AbWJ3Rd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:33:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lodfD+PNTc9M9BRtf3+iqBQQbdaB2EDWHEsA410EzmfMBAQI+5FMCKpFDVrS6hE2EwiIMS7Xkc1ShD6LOJJu5HkVFjxcDHw5krUli94wRMxF1RnwPVk1wOcpKM8SkPw40qWDlQ8H5FLymN1jxD9S+reG8+m43j7gjBbeX1yX04k=
Message-ID: <9a8748490610300933t793e0aaew1016f03410f2f96@mail.gmail.com>
Date: Mon, 30 Oct 2006 18:33:25 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Metathronius Galabant" <m.galabant@googlemail.com>
Subject: Re: user-space command "ipcs" seems broken on 2.6.18.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1b270aae0610300515u502e5819g256c9de438d064f8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1b270aae0610300414u4175fec6i30a1396dde260ca1@mail.gmail.com>
	 <9a8748490610300432m45e560f8gdaeb951877e2532e@mail.gmail.com>
	 <1b270aae0610300437u1529b5ddo5a365a06f16611c@mail.gmail.com>
	 <1b270aae0610300515u502e5819g256c9de438d064f8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/06, Metathronius Galabant <m.galabant@googlemail.com> wrote:
> > Can you identify the latest kernel where it works OK?
>
> I can't reproduce that behaviour on another SMP machine with the same
> kernel-config for 2.6.18.1 (only storage and network device drivers
> differ).
> The affected one is a production machine I can't use to test, and
> furthermore the only one I've got of that series.
>
Ok, can you then at least tell us what the latest kernel you have used
that was OK was?
Just to try and narrow things down a bit.

> Has to wait until the weekend. Any remote clue so I know where to look?

Well, with a simple good/bad test case like you have, the obvious
thing to do would be to find a resonably new kernel that's good and
one that's bad and then do a git bisection search to find the exact
commit that broke things for you. Short of that, narrowing it down to
a released version, a -rc or -git snapshot is also good.

You could also start browsing through changelogs looking for changes
to IPC and then try revert patches that look likely. But  git bisect
is probably a lot easier.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
