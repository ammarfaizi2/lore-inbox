Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSETCLf>; Sun, 19 May 2002 22:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315722AbSETCLe>; Sun, 19 May 2002 22:11:34 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:26889 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315720AbSETCLe>;
	Sun, 19 May 2002 22:11:34 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205200211.g4K2BPH504914@saturn.cs.uml.edu>
Subject: Re: [RFC/PATCH] improve interaction with ccache
To: kaos@ocs.com.au (Keith Owens)
Date: Sun, 19 May 2002 22:11:25 -0400 (EDT)
Cc: kai-germaschewski@uiowa.edu (Kai Germaschewski),
        linux-kernel@vger.kernel.org
In-Reply-To: <1764.1021857248@kao2.melbourne.sgi.com> from "Keith Owens" at May 20, 2002 11:14:08 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> Kai Germaschewski <kai-germaschewski@uiowa.edu> wrote:

>> As various people pointed out, ccache is a great win for people compiling 
>> a lot of kernels. (For info on ccache, see ccache.samba.org)
...
> You are fixing the symptom, not the cause.  The symptom is too many
> compiles, people are using ccache to attempt to fix the symptom.  The
> cause is a kernel build system that forces people to make clean or
> mrproper between builds instead of reusing existing objects.
>
> Fix the cause, not the symptom.

Cause: gcc is slow
Symptom: builds are slow
Fix: make gcc fast

That fix won't happen, so we cache the results.
We have two ways to do this:

a. use "make", relying solely on timestamps
b. use "ccache", which uses an md5 checksum AFAIK

With ccache, one could even get rid of make.
It's redundant; just use a shell script. :-)

