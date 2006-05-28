Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWE1QRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWE1QRV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWE1QRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:17:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:56525 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750788AbWE1QRU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:17:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YCuOG597TzmeanVGmZzhrdivePGRQHOM5ZjWh+SoWcrprwFkzA3uW+QssyEpUTitP6khXhFUuQ8Wo1jMb/gpACfwyCQGdM8GLIPqJeA1APoWiwh0SN6Cg9/XJr8N9BSNqZ6jpkf0K1oYFAYhTNuL+dEjcVrpnQr/u276EnA0xIs=
Message-ID: <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com>
Date: Sun, 28 May 2006 18:17:19 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "=?ISO-8859-1?Q?Haar_J=E1nos?=" <djani22@netcenter.hu>
Subject: Re: How to send a break? - dump from frozen 64bit linux
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <004501c68225$00add170$1800a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs>
	 <20060527234350.GA13881@voodoo.jdc.home>
	 <004501c68225$00add170$1800a8c0@dcccs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/06, Haar János <djani22@netcenter.hu> wrote:
>
> Can somebody tell me, what is wrong exactly?
>
I can't tell you exactely what's wrong unfortunately, but after
looking at your dump & dmesg I notice two things that might be worth
trying to change :

1) You seem to be running without any swap space at all. I't usually a
good idea always to have some swap configured - try adding a swap
file.
(note: I don't think this will help with your current problem, it's
just a good thing to do generally).

2) You should try the latest stable kernel. Currently that's 2.6.16.18
(http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.18.tar.bz2).
There have been lots of fixes added since 2.6.15.x and perhaps you are
lucky that whatever is giving you trouble  has already been fixed in
that kernel.


> Anyway, i interested about, how can i -a single user- interpret these dump
> to made error reporting more useful?
>
You can find some info in Documentation/sysrq.txt &
Documentation/oops-tracing.txt .
As for posting good error/bug reports, please read the REPORTING-BUGS
file in the root of the kernel source dir.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
