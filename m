Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316679AbSEVS6Q>; Wed, 22 May 2002 14:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSEVS6P>; Wed, 22 May 2002 14:58:15 -0400
Received: from daimi.au.dk ([130.225.16.1]:33351 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S316679AbSEVS6O>;
	Wed, 22 May 2002 14:58:14 -0400
Message-ID: <3CEBEA42.A614EBB5@daimi.au.dk>
Date: Wed, 22 May 2002 20:58:10 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <E17AXVZ-0001up-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > In such case, linus, here is your "reasonable" example. For PPro, it
> > is faster to copy out-of-order, and if we wanted to use that for
> > copy_to_user, you'd have your example.
> 
> I think there is a misunderstanding here.
> 
> Nothing in the standards says that
> 
>         write(pipe_fd, halfmappedbuffer, 2*PAGE_SIZE)
> 
> must return PAGE_SIZE on an error. What it seems to say is that it if an error
> is reported then no data got written down the actual pipe itself. Putting
> 4K into the pipe then reporting Esomething is not allowed. Copying 4K into
> a buffer faulting and erroring with Efoo then throwing away the buffer is
> allowed

write might be the easy case. But what about read?
Is a failing read allowed to change the userspace
memory?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
