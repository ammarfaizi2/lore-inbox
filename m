Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130252AbRCLNwt>; Mon, 12 Mar 2001 08:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130381AbRCLNwj>; Mon, 12 Mar 2001 08:52:39 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:16557 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130380AbRCLNwd>; Mon, 12 Mar 2001 08:52:33 -0500
Date: Mon, 12 Mar 2001 14:51:46 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Art Boulatov <art@ksu.ru>, linux-kernel@vger.kernel.org
Subject: Re: filesystem for initrd
Message-ID: <20010312145146.A878@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3AAAC179.8020109@ksu.ru> <3AAAC6C5.EF198D4A@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AAAC6C5.EF198D4A@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Mar 10, 2001 at 07:28:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2001 at 07:28:53PM -0500, Jeff Garzik wrote:
> cramfs is nice but still read-only at the moment...  You might be able
> to get away with stacking ramfs on top of that. 

What is easier because this ...

> If not, it shouldn't be hard to modify cramfs so that it allows
> fs modifications...  just stick the updated pages in RAM until
> the file is unlinked or the fs is unmounted.

... will lead into problems accounting available space on the fs,
since openers don't expect that they cannot write to a file
anymore, just because we we are out of RAM for backing the
writes.

I think unionfs will care for this kind of problems once we have
it implemented in an official tree.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
