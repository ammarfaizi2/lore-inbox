Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131474AbRC0SV6>; Tue, 27 Mar 2001 13:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131476AbRC0SVs>; Tue, 27 Mar 2001 13:21:48 -0500
Received: from [195.227.87.20] ([195.227.87.20]:19208 "EHLO d12.x-mailer.de")
	by vger.kernel.org with ESMTP id <S131474AbRC0SVg>;
	Tue, 27 Mar 2001 13:21:36 -0500
From: Tea Age <th@visuelle-maschinen.de>
To: linux-kernel@vger.kernel.org
Subject: module depencies during startup
Date: Tue, 27 Mar 2001 20:09:13 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01032720091303.05310@iris-linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

this is my very first mail into this list. If, please answer also to my mail 
address <th@visuelle-maschinen.de>. I have the following question and could 
not find any info about this matter in the web - maybe someone knows a link:

Porting the framebuffer driver i810fb to 2.4 I succeded loading it as a 
module. Compiling it into the kernel seems to be ok - but no Tux.

I found out, that agpgart, which is needed by i810fb, is initialized
_after_ i810fb setup. Therefore i810fb failes to initialize.
If I understand the kernel sources right, there is a function pointer list 
from __initcall_start for initializing compiled-in drivers. Unfortionately I 
could not discover how to control the sequence of this pointer list. The 
__initcall technique seems to be new in 2.4.  The same driver initializes 
correct on a 2.2.18 kernel.

In fact this seems to be a  general problem which, I guess, is already solved 
- but how?

Any hints are welcome - thanks in advance!

Thomas
