Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261498AbTCGLZf>; Fri, 7 Mar 2003 06:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbTCGLZf>; Fri, 7 Mar 2003 06:25:35 -0500
Received: from angband.namesys.com ([212.16.7.85]:28803 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261498AbTCGLZe>; Fri, 7 Mar 2003 06:25:34 -0500
Date: Fri, 7 Mar 2003 14:36:07 +0300
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5] memleak in load_elf_binary?
Message-ID: <20030307143607.E7347@namesys.com>
References: <20030307141247.D7347@namesys.com> <20030307032532.17d37207.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307032532.17d37207.akpm@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 07, 2003 at 03:25:32AM -0800, Andrew Morton wrote:
> >    I am still playing with improving memleak detector thing from smatch project.
> >    Seems there is a memleak in fs/binfmt_elf.c::load_elf_binary() in current 2.5
> >    If setup_arg_pages() fails (line 638 in my sources) we do return but 
> >    not freeing possibly allocated elf_interpreter (line 520) and 
> >    allocated elf_phdata (line 500) areas.
> >    Is this looking real? At least it looks real for me (I am trying to get
> >    number of false positives way down).
> Yes, you're right.  And there's a second one further down.

Ah, hm? Can you be mo precise? I do not see it.

Next return I see is in line 745, and the memory is freed before it.

Bye,
    Oleg
