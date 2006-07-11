Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWGKRQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWGKRQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWGKRQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:16:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:51055 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751098AbWGKRQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:16:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l1DC1uRiwUWcsAFxmAXuZxTMZ5wnHRBDA1c1/DCyzz8+vgwImyTIiSgqxIq/RT0UpJaRFNeis7KfZeKbjhAKUnXJcE7fT8yjwDkeABW+roG+tNlZbTvTIW9ICymAHBC9k6cdWhXXcNDAeQ18gRni0zkiZitr/Au85XOToyYQN2A=
Message-ID: <bda6d13a0607111015p5ab5461am4f6b4716e264e0e1@mail.gmail.com>
Date: Tue, 11 Jul 2006 10:15:59 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Adrian Bunk" <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, "David Woodhouse" <dwmw2@infradead.org>,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
In-Reply-To: <20060711170725.GD5362@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060711160639.GY13938@stusta.de>
	 <20060711170725.GD5362@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Dave Jones <davej@redhat.com> wrote:
> On Tue, Jul 11, 2006 at 06:06:39PM +0200, Adrian Bunk wrote:
>  > I'd like to cleanup the mess of the in-kernel headers, based on the
>  > following rules:
>  > - every header should #include everything it uses
>  > - remove unneeded #include's from headers
>  >
>  > This would also remove all the implicit rules "before #include'ing
>  > header foo.h, you must #include header bar.h" you usually only see when
>  > the compilation fails.
>
> You may want to add as a secondary goal, splitting up some of the
> huge 3-headed monster include files like sched.h
> (It's better than it used to be, but it still sucks, and that thing
> #include's the world).  Worst, iirc module.h pulls it in, which means
> everything built as a module is pulling in hundreds of includes
> even though most of the time, it'll never use anything from the
> indirect ones.
If you pull this off, you can shave a lot off compile time as almost
every component #includes module.h
