Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTLJWty (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 17:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTLJWtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 17:49:53 -0500
Received: from cantvc.canterbury.ac.nz ([132.181.2.36]:60933 "EHLO
	cantvc.canterbury.ac.nz") by vger.kernel.org with ESMTP
	id S264256AbTLJWtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 17:49:52 -0500
Date: Thu, 11 Dec 2003 11:49:53 +1300
From: Oliver Hunt <ojh16@student.canterbury.ac.nz>
Subject: Re: Linux GPL and binary module exception clause?
In-reply-to: <Pine.LNX.4.58.0312100809150.29676@home.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <3FD7A311.9060807@student.canterbury.ac.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.5b)
 Gecko/20030727 Thunderbird/0.1
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org>
 <Pine.LNX.4.58.0312100714390.29676@home.osdl.org>
 <20031210153254.GC6896@work.bitmover.com>
 <Pine.LNX.4.58.0312100809150.29676@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
...
> There's a fundamental difference between "plugins" and "kernel modules":
> intent.
> 
...

The key difference between a plugin and a module(from my understanding 
of plugins in browser/application sense) is how information is passed.

Says we have the flash plugin for some random browser, say BrowserApp 
1.01, now the browser comes across a flash file, now it calls the flash 
plugin, passing both the file, and the graphics context the plugin can 
draw to.  Flash does it's rendering and then shoves it's output to the 
canvas: that's all it can do, it may make a request (say, 
browser::getURL) but that's about it, and the browser can always ignore it.

Now there is competitor to BrowserApp known as BrowserOS, instead of 
plugins it has modules.  Now, when BrowserOS comes across a flash file 
it loads it's flash module and passes the url, at which point the module 
takes over, and allocates a graphics context for it to draw to(see it 
controls what happens, rather than the otherway round).  Now say the 
module wants to load a webpage it now tells the address bar to change, 
then it makes internal changes (loads the new url, etc), that the 
browser _cannot_ stop, it is effectively part of the program...

--Oliver

