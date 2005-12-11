Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVLKVGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVLKVGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 16:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVLKVGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 16:06:16 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:14954 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750754AbVLKVGP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 16:06:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aR+wH5Ifjlow7CDBwK7SuDJ1ZMHq4UsNCXy0Q7Y+F6F5CidYWMODFLYkxJK3/ZnS1Qj2ubbh6aNbP2KGueQL7fqsUd0j9vF5Jn2iE5rSQaMqb6VouE5fgptJGOtyGjLCXsqvjEsf4A+2IyHQO5fHJUdni3WKlsVYdc9mKnAYHvM=
Message-ID: <9a8748490512111306x3b01cb8cw2068a7ad3af93b03@mail.gmail.com>
Date: Sun, 11 Dec 2005 22:06:14 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML List <linux-kernel@vger.kernel.org>
Subject: Yet more display troubles with 2.6.15-rc5-mm2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the problem I reported earlier about 2.6.15-rc5-mm2
hanging at boot with vga=791 I've just discovered another problem.

If I boot with vga=normal (which is aparently all that works), then I
can boot up to a nice lain text login and run startx, but if I then
switch away from X back to a text console with ctrl+alt+f6 or if I
shut down X, then I'm presented with a completely garbled text mode
screen - flashing coloured blocks all over, random bits of text at
random locations etc.

Also, when starting X, just before the cursor appears I normally just
have a black screen. With this kernel I first get a short blink of a
garbled graphics mode screeen with either what looks like just random
pixels or sometimes with something that looks like a mangled snapshot
of my text mode console, or if I kill X with ctrl+alt+backspace and
then start it again (the garbled text mode console does work, although
I'm glad I know how to touch type ;) then I sometimes get what looks
like a snapshot of my previous X session with random pixels on top.
The garbled graphical screen stays for just a blink of an eye, then
it's replaced with the normal black screen and the mouse cursor.

2.6.15-rc5-git1 works perfectly without these issues.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
