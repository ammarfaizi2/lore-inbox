Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbUAMKLi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 05:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUAMKLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 05:11:38 -0500
Received: from linuxhacker.ru ([217.76.32.60]:12214 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263810AbUAMKLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 05:11:34 -0500
Date: Tue, 13 Jan 2004 12:10:29 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Dan Egli <dan@eglifamily.dnsalias.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x breaks some Berkeley/Sleepycat DB functionality
Message-ID: <20040113101029.GD2224@linuxhacker.ru>
References: <4002D65C.1010505@eglifamily.dnsalias.net> <16387.49164.269996.500699@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16387.49164.269996.500699@laputa.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Jan 13, 2004 at 12:53:16PM +0300, Nikita Danilov wrote:
>  > I run a PGP Public key server on this machine and under 2.4.x it's
>  > "smooth as silk". But if I boot under 2.6.x, it's gaurenteed failure. If
>  > I try to build a database using the build command (this is an sks
>  > server, so it's sks build or sks fastbuild) I IMMEDIATELY get  Bdb
>  > error. But the exact same command with the exact same libraries and
>  > input files under 2.4.20 works without a hitch.
>  > Anyone got any ideas? Anything else I can provide to assist in debugging?
> On top of what file system berkdb is created? I have a reminiscence that
> Sleepy Cat used to have a problem with reiserfs, due to large
> stat->st_blksize value. Oleg do you remember this?

No, that problem was different. And it was believed that BErkeley DB might just
be performing a bit slower on reiserfs, though I never was able to reproduce and
Sleepycat's code contains it own limit on maximal block size (it uses 16k
blocksize if on suggested by FS is bigger that 16k).
Definitely there were no crashes.

Bye,
    Oleg
