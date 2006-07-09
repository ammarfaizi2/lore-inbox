Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161118AbWGIUZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbWGIUZl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWGIUZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:25:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:9777 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161118AbWGIUZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:25:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=psgO2l2Swn7WN23mTjodeMUibz4UqfyL6t3NN7uMu679FrArvGJ5fOiKbCHrrVMRBz6tJanCjcgHMFpm4kYsO4zTQvZqMKSpfW47gfLpd+zSnN4/MeUraS2RNzbM2d6uSyy9vyioS7SJUCD5eQaVksto4e9xZLEFHn3SPvJzLZo=
Message-ID: <9a8748490607091325q7c4bed0etffb15fda227c6232@mail.gmail.com>
Date: Sun, 9 Jul 2006 22:25:38 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Daniel Bonekeeper" <thehazard@gmail.com>
Subject: Re: Automatic Kernel Bug Report
Cc: "Adrian Bunk" <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
	 <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com>
	 <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com>
	 <20060709125805.GF13938@stusta.de>
	 <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com>
	 <20060709191107.GN13938@stusta.de>
	 <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/06, Daniel Bonekeeper <thehazard@gmail.com> wrote:
...
>
> Hopefully, in some bugs where nothing is printed (i.e., syslog died,
> is not running, or we are in kernel context and never get back to user
> mode), having a notifier on the kernel may ensure that the bug report
> is sent (since we don't need userspace interaction to get it working).
>
...

Have you considered the privacy implications of this?

If you implement something like this it most definately needs to be
configurable and default to *OFF* and need explicit user intervention
to turn on.
Also consider that any data transmitted should probably be encrypted
during transmission - not something you want to start doing after you
just Oops'ed.

I for one certainly do *NOT* want my kernel to "phone home" and
disclose information about my computer without my concent - that, in
my book, is called spyware.

Consider this :

If my machine connects to some off-site location and submits an Oops
at least the following information about me will (or may) be disclosed
:

- My IP address.
- My OS.
- Portions of memory on my machine that may contain sensitive info
(encryption keys for instance or personal data).
- Name(s) of applications I have running.
- gcc version of the compiler I used to build the kernel.
- Details of hardware I have in the box (architecture etc).

and probably a lot more that I've forgotten to include.

I consider the above info privileged and personal and something that
requires my explicit concent to release. It's *NOT* something I want
my computer to submit off-site without me knowing about it.

Also consider that I may be using a labtop and be connected to a
network where I may not be allowed to connect off-site except under a
specific set of circumstances. This thing could make me violate such a
policy without knowing about it.

I may also be connected to a network where the firewall logs all my
outgoing connections and I may not want people to know I'm running
Linux. A Linux kernel Oops from my machine showing up in the firewall
logs would certainly disclose that fact.

There are more things to consider than just "would this be useful for
kernel development" - privacy in this case is a major issue.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
