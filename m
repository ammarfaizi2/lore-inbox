Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSLVTJP>; Sun, 22 Dec 2002 14:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbSLVTJP>; Sun, 22 Dec 2002 14:09:15 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:25826
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265108AbSLVTJO>; Sun, 22 Dec 2002 14:09:14 -0500
Message-ID: <3E060FD9.40305@redhat.com>
Date: Sun, 22 Dec 2002 11:17:45 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212221047570.2587-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212221047570.2587-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>>I presume *%gs:0x18 is only for shared objects?
> 
> 
> No, it's for everything, but it requires a glibc that has set it up.

Actually, the above is used only in the DSOs.  In static objects I'm
using a global variable.  This saves the %gs prefix.

But of course Linus is right: using the new functionality needs quite a
bit of infrastructure which most definitely isn't present in the libc
you have on your system.  See my post from a few minutes ago.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

