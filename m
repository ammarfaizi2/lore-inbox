Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279250AbRJWFjK>; Tue, 23 Oct 2001 01:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279251AbRJWFjB>; Tue, 23 Oct 2001 01:39:01 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:63492 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279250AbRJWFim>;
	Tue, 23 Oct 2001 01:38:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM 
In-Reply-To: Your message of "Mon, 22 Oct 2001 20:59:40 +0200."
             <20011022185859Z16022-4006+539@humbolt.nl.linux.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Oct 2001 15:38:55 +1000
Message-ID: <1337.1003815535@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 20:59:40 +0200, 
Daniel Phillips <phillips@bonn-fries.net> wrote:
>If you want to argue for something, argue for giving config the ability to 
>apply patches, that would be lots of fun.

cc list trimmed.

It is kbuild rather than config that needs the ability.  I could do it
trivially in kbuild 2.5, I almost added the facility at one time.  Alas
it breaks when you get overlapping patches, select one config or
another and it works, select both (assuming they are not exclusive) and
it breaks.

I don't have a solution and the symptoms of overlapping patches are
worse than the problem that patches are trying to fix, so I left patch
support out of kbuild 2.5.  You can use shadow trees where you overlay
a new implementation of a subsystem over the base kernel, then switch
between versions by specifying which set of trees you are using.

http://sourceforge.net/projects/kbuild

