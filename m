Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286168AbRLZGmq>; Wed, 26 Dec 2001 01:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286187AbRLZGmg>; Wed, 26 Dec 2001 01:42:36 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:2308 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286186AbRLZGm1>; Wed, 26 Dec 2001 01:42:27 -0500
Date: Wed, 26 Dec 2001 09:42:09 +0300
From: Oleg Drokin <green@namesys.com>
To: Weiping He <laser@zhengmai.com.cn>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: anybody know about "journal-615" and/or "journal-601" log error?
Message-ID: <20011226094209.B871@namesys.com>
In-Reply-To: <005401c18dc6$f3e3fb10$d20101c0@T21laser>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005401c18dc6$f3e3fb10$d20101c0@T21laser>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Dec 26, 2001 at 12:36:18PM +0800, Weiping He wrote:

>     but I've experienced server hang up of my box, the syslog entity is:
>     (this show up after I re-compile the kernel with the reiserfs's:
>         Have reiserfs do extra internal checking
>         Stats in /proc/fs/reiserfs
>      options set to enable)
> Dec 26 09:47:10 x200 kernel: journal-615: buffer write failed
> Dec 18 10:19:13 x200 kernel: journal-601, buffer write failed
Any other errors in the logs?
Reading the code these errors appear after we put IO request
and then watitng for it to be complete with wait_on_buffer().
But after wait_on_buffer returns, bufer is still not up to date,
which usually means IO request have failed for some reason.

> I've experienced power failure before the problem happens.
> and after it happens, in `top' I can see that `kupdated' mark as <debunc>
Yes, because there was an Oops after this message.

> my question is what's the matter here? I do some search in kernel archive
> but found almost nothing relate that 'journal-615' or 'journal-601'.

> Is it a bug or my sw/hw configure problem?
Right now it looks more like a HW problem.
Can you dig more messages from your kernel log.
Can you try to run reiserfsck on a problematic partition and see
if there is anything wrong?

Bye,
    Oleg
