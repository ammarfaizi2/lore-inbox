Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290589AbSBKXDx>; Mon, 11 Feb 2002 18:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290590AbSBKXDn>; Mon, 11 Feb 2002 18:03:43 -0500
Received: from relay-1v.club-internet.fr ([194.158.96.112]:42492 "HELO
	relay-1v.club-internet.fr") by vger.kernel.org with SMTP
	id <S290589AbSBKXDj>; Mon, 11 Feb 2002 18:03:39 -0500
Message-ID: <3C684EF2.2040609@freesurf.fr>
Date: Tue, 12 Feb 2002 00:08:34 +0100
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020208
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: SA products <super.aorta@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: faking time
In-Reply-To: <3C67AFD3.722C5471@ntlworld.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SA products wrote:
> Dear Kernel list,
> 
> I want to fake the time returned by the time() system call so that for a
> limited number
> of user space programs the time can be set to the future or the past
> without affecting
> other applications and without affecting system time-- Ideally I would
> like to install a
> loadable module to accomplish this- Any hints ? Any starting points?

Maybe could you use a shared library loaded with LD_PRELOAD that
overrides the libc's time() function ?
IMHO this is simpler (and safer) than writing a kernel module, but
it will only work with dynamically linked programs, not with static
nor suid-ed programs.

-- 
** Gael Le Mignot "Kilobug", Ing3 EPITA - http://kilobug.free.fr **
Home Mail   : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

"Software is like sex it's better when it's free.", Linus Torvalds

