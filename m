Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVAMW5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVAMW5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVAMWxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:53:46 -0500
Received: from cc15144-a.groni1.gr.home.nl ([217.120.147.78]:1456 "HELO
	boetes.org") by vger.kernel.org with SMTP id S261803AbVAMWw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:52:26 -0500
Date: Thu, 13 Jan 2005 23:52:22 +0100
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
Message-ID: <20050113225244.GH14127@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050113134620.GA14127@boetes.org> <a36005b5050113131179d932eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b5050113131179d932eb@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Aside from all the arguments about why this patch isn't good for
> the kernel, everybody should be aware that the ProPolice gcc
> patches are pretty unusable. They rely in recognizing certain
> tree patterns which for some architectures do not exist, and for
> others can look differently, depending on the optimization. To
> paraphrase one of the gcc developers: "this kind of
> functionality should be written to work _with_ gcc, not
> _against_ it as the propolice patch does".
>
> Before you suggest using something like this patch you better
> first inform yourself by asking the people who actually know the
> code which is modified.

Ok I have a problem here. You are Ulrich Drepper and you are _the_
maintainer of glibc and I am Han Boetes and I am a C noob. It's
like Kasparov trying to explain something to a club-chess-player.

I'm afraid that whatever explanation you give to me is over my
head, you'll feel like talking to a dummy and I'll be terribly
unsatisfied.

To avoid that I would like to ask you if you can show me some
example-code, something I which can compile and run and see for
myself, for the following situations:

1) Where an application compiled with PP is working worse or even
   failing where it would work right without PP.

2) Where a bufferoverflow can be exploited even though the
   application is compiled with PP.


As an example where PP does work right the test-code provided by
the propolice maintainer:

    /* test-propolice.c */
    #define OVERFLOW "This is longer than 10 bytes"
    #include <string.h>
    int main (int argc, char *argv[]) {
        char buffer[10];
        strcpy(buffer, OVERFLOW);
        return 0;
    }




# Han
