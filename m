Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278080AbRJVIVp>; Mon, 22 Oct 2001 04:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278087AbRJVIVf>; Mon, 22 Oct 2001 04:21:35 -0400
Received: from rj.sgi.com ([204.94.215.100]:52880 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S278080AbRJVIVV>;
	Mon, 22 Oct 2001 04:21:21 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
In-Reply-To: Your message of "Mon, 22 Oct 2001 04:05:54 -0400."
             <Pine.GSO.4.21.0110220404000.2294-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Oct 2001 18:21:47 +1000
Message-ID: <23837.1003738907@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 04:05:54 -0400 (EDT), 
Alexander Viro <viro@math.psu.edu> wrote:
>On Mon, 22 Oct 2001, Keith Owens wrote:
>> On Mon, 22 Oct 2001 02:47:39 -0400 (EDT), 
>> Alexander Viro <viro@math.psu.edu> wrote:
>> >post-install binfmt_misc mount -t binfmt_misc none /proc/sys/binfmt_misc
>> >pre-remove binfmt_misc umount /proc/sys/binfmt_misc
>> 
>> It is not hard wired in the standard modutils, because there is no way
>> of overriding it.
>
>???
>Elaborate, please.

When the post-install and pre-remove entries for module binfmt_misc are
hard coded into modprobe, there is no syntax in modules.conf to prevent
modprobe from always issuing those commands.  The next time somebody
decides that binfmt_misc needs different commands, everybody using the
old modutils on the new kernel will break.  I don't want the hassle,
put it in modules.conf where it can easily be changed.

If I can get an iron clad guarantee that binfmt_misc will never, ever
change again then I might consider hard coding the entries in modprobe.
BTW, I will need a signature in blood that says I can kill you if
binfmt_misc is ever changed :).

