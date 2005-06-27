Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVF0TLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVF0TLL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVF0THr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:07:47 -0400
Received: from smtpout.mac.com ([17.250.248.71]:19146 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261619AbVF0TGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:06:13 -0400
In-Reply-To: <20050627183118.GB1415@elf.ucw.cz>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050627183118.GB1415@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4DB694DE-E3E8-4F72-8888-9529D2CC16B9@mac.com>
Cc: Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Mon, 27 Jun 2005 15:05:47 -0400
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 27, 2005, at 14:31:18, Pavel Machek wrote:
> pavel@Elf:/data/tmp/linux-hg$ hg init http://www.kernel.org/hg/
> Traceback (most recent call last):
>   File "/usr/local/bin/hg", line 11, in ?
>     from mercurial import commands
> ImportError: No module named mercurial

Apparently your Python does not automatically look in /usr/local/lib/ 
python
and you don't have PYTHONPATH=/usr/local/lib/python.  Try adding the  
following
to your .bash_profile, then logging out and back in again:

if [ -z "$PYTHONPATH" ]; then
     PYTHONPATH=/usr/local/lib/python
else
     PYTHONPATH="$PYTHONPATH:/usr/local/lib/python"
fi
export PYTHONPATH

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't.  
That's why
I draw cartoons. It's my life."
-- Charles Shultz

