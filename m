Return-Path: <linux-kernel-owner+w=401wt.eu-S932302AbXAOMn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbXAOMn5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 07:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbXAOMn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 07:43:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:16062 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302AbXAOMn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 07:43:56 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=feNQOKZC9/ShP6TFBU4R3CvMjaESC+eAoMYmV3YOeyS13w/4l5R3/pPJpznJgBwNmhnlnuPxyxE4yyqHIeC3YMNcfCWoMipTq2kp8ygsqbxizSkiPuV/5K+D1WEJKcKg5c5QvqFpzzRg667yo5bOBOM7yMpLFrs95Gp3YaRU+Cs=
Message-ID: <9b53a56d0701150443o7213ef6at4f877cca0d4aa377@mail.gmail.com>
Date: Mon, 15 Jan 2007 07:43:53 -0500
From: "Chris Smith" <smitty1elkml@gmail.com>
To: "Pelle Svensson" <pelle2004@gmail.com>
Subject: Re: Skeleton, Makefile extension - Separate source tree with only valid source files
Cc: linux-kernel@vger.kernel.org, "Sam Ravnborg" <sam@ravnborg.org>
In-Reply-To: <6bb9c1030701150135x173f95c0lb67247b641137367@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bb9c1030701150135x173f95c0lb67247b641137367@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/07, Pelle Svensson <pelle2004@gmail.com> wrote:
> Did some hacks to the Makefile which might be of interest for those who
> feel like there are too many source files in the Linux tree. Running following
> make will create a separate directory including only the files which are
> active i.e. they are include in the final build configuration.
>
> source = /home/john/src/linux-2.6.20
> build_dir = /home/john/src/linux-2.6.20-build
> edit_dir = /home/john/src/linux-2.6.20-edit
>
> cd $(source)
> make O=$(build_dir) ACTIVE_SRC=$(edit_dir) active_srctree
>
> Links will be create in $(edit_dir) and what ever IDE that are in use for
> editing should target the $(edit_dir). The good thing is that grep will only
> hit valid files not 50 other files which are not in my interest.
>
>
> Due to lack of time this is not complete. Phrasing the dependency need to
> be added for all the include files.
>
[snip]

Another interesting thought might be to have kbuild run all of the
files through the pre-processor, then indent.
Then one could have a clearer view of the kernel object as actually
seen by the compiler.
Thanks, Pelle.
--Chris
