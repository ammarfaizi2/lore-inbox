Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315411AbSEMBFI>; Sun, 12 May 2002 21:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315461AbSEMBFH>; Sun, 12 May 2002 21:05:07 -0400
Received: from [202.135.142.196] ([202.135.142.196]:2576 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315411AbSEMBFE>; Sun, 12 May 2002 21:05:04 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: andersen@codepoet.org
Cc: Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Some useless cleanup 
In-Reply-To: Your message of "Thu, 09 May 2002 16:23:58 CST."
             <20020509222358.GB8651@codepoet.org> 
Date: Sun, 12 May 2002 22:09:54 +1000
Message-Id: <E176sAl-0000ct-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020509222358.GB8651@codepoet.org> you write:
> On Thu May 09, 2002 at 10:36:50PM +1000, Rusty Russell wrote:
> > Um, why not simply:
> > 
> > static inline void set_name(struct task_struct *tsk, const char *name)
> > {
> > 	/* comm is always nul-terminated already */
> > 	strncpy(tsk->comm, name, sizeof(tsk->comm)-1);
> > }
> > 
> > Your implementation using snprintf is (wasteful and) dangerous,
> > Rusty.
> 
> And both implementations suffer from the fact that if tsk->comm
> were to change from a fixed length array to a char*, allowing
> arbitrarily sized names, you would end up copying very little
> indeed.  :)

Um, yes, if someone were to make a random change to the kernel without
looking at what it would effect, the kernel would likely break.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
