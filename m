Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262015AbREPRRf>; Wed, 16 May 2001 13:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262017AbREPRRZ>; Wed, 16 May 2001 13:17:25 -0400
Received: from [206.14.214.140] ([206.14.214.140]:9740 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S262015AbREPRRL>; Wed, 16 May 2001 13:17:11 -0400
Date: Wed, 16 May 2001 10:16:56 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B023A68.9B9F7D0F@idb.hist.no>
Message-ID: <Pine.LNX.4.10.10105161013550.17255-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> mmap is fine for a fb, but please don't remove read/write.
> I can now do a screendump with "cat /dev/fb/0 > file", 
> because everything is a file.
> Having 
> /dev/fb/0/brightness
> /dev/fb/0/opengl
> and so on seems to be a better approach.

One I like to name of the file system to be something else. This way apps
can move over to it. You will still be able to do the above. I plan to
have for each framebuffer

/dev/gfx/frameX. 

So say your card can do double buffer you could do 

cat /dev/gfx/frame0 > file1
cat /dev/gfx/frame1 > file2

So you could access the double buffer as well :-)

