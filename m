Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278356AbRJMSv4>; Sat, 13 Oct 2001 14:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278359AbRJMSvr>; Sat, 13 Oct 2001 14:51:47 -0400
Received: from zeus.kernel.org ([204.152.189.113]:42399 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S278356AbRJMSvh>;
	Sat, 13 Oct 2001 14:51:37 -0400
Message-ID: <3BC88AB3.2040707@laotraesquina.com.ar>
Date: Sat, 13 Oct 2001 15:40:51 -0300
From: Pablo Alcaraz <pabloa@laotraesquina.com.ar>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: es-ar, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@transmeta.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <Pine.LNX.4.33.0110130956350.8707-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whatever will be the chosen solution, it would have to allow to 
overwrite all the executables and libraries files (if we have enough 
permissions).

Because:

- If I overwrite a shared library and then one running program crash, it 
will be my fault (as system administrator) or mistake.. ;-)

- It is probable that one file library is updated within one more global 
update, then probably I restart later the new demon or program. So if 
the program crash I'll fix the problem eventually.

- The previous version of a file library that I am replacing can depend 
on another file that the installer of the new version of the program 
simply erases it. For example:

a.so depends of b.so

but

a_new_version.so does not depend of b.so.

When I or an installer install the new program version, me or the 
installer erase b.so because the new version doesn't use it.

So, that it matters if a program can or can't access to the old version 
of a.so if b.so was erased?

And eventually, if I decide to update a library, I would have to do it 
(I suspect it would be the same case with executables files). It doesn't 
the matter if the change implies a fault in a running program.


It can be that this serves so that a hacker can attack the system... or 
I could hang a program when this is not my objective. Maybe a flag in 
/proc/somewhere would be am useful thing:

- if it's 1, I can overwrite all the libraries and executables files (If 
I've permission, etc.);

- if it's 0, I can not overwrite anything If it's in use.

I only want that everybody respect my right to do the wrong or stupid 
thing. This is an system administrator right :-)


Pablo


