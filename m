Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSEIVyC>; Thu, 9 May 2002 17:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314404AbSEIVyB>; Thu, 9 May 2002 17:54:01 -0400
Received: from slip-202-135-75-38.ca.au.prserv.net ([202.135.75.38]:57216 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314403AbSEIVyB>; Thu, 9 May 2002 17:54:01 -0400
Date: Thu, 9 May 2002 22:36:50 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Some useless cleanup
Message-Id: <20020509223650.2d7a9f6a.rusty@rustcorp.com.au>
In-Reply-To: <20020509102841.GA1125@stingr.net>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002 14:28:41 +0400
Paul P Komkoff Jr <i@stingr.net> wrote:

> Look at this very funny cleanup changeset for 2.4
> avaliable at linux-stingr.bkbits.net/comm

Um, why not simply:

static inline void set_name(struct task_struct *tsk, const char *name)
{
	/* comm is always nul-terminated already */
	strncpy(tsk->comm, name, sizeof(tsk->comm)-1);
}

Your implementation using snprintf is (wasteful and) dangerous,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
