Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUEQTqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUEQTqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUEQTqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:46:34 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:45440
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262634AbUEQTq2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:46:28 -0400
From: Rob Landley <rob@landley.net>
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Date: Wed, 12 May 2004 11:39:58 -0500
User-Agent: KMail/1.5.4
References: <20040506131731.GA7930@wohnheim.fh-wedel.de>
In-Reply-To: <20040506131731.GA7930@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200405121139.58742.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 May 2004 08:17, Jörn Engel wrote:
> Couldn't sleep last night and finished a first complete version of
> cowlinks, code-named MAD COW.  It is still based on the stupid old
> design with a flag to distinguish between regular hard links and
> cowlinks.  Please don't comment on that design, it's just a proof of
> concept.

Catching up on some really old mail, I thought I'd ask:

For years now I've wanted to use a sendfile variant to tell the system to 
connect two filehandles from userspace.  Not just web servers want to 
marshall data from one filehandle into another, things like netcat want to do 
it between a pipe and a network connection, and I've wrote a couple of data 
dispatcher daemons that wanted to do it between two network connections.

Unfortunately, sendfile didn't work generically when I tried it (back under 
2.4).  Would this infrastructure be a step in the right direction to 
eliminate gratuitous poll loops (where nobody but me EVER seems to get the 
"shutdown just one half of the connection" thing right.  My netcat can handle 
"echo 'GET /' | netcat www.slashdot.org 80".  The standard netcat can't.  
Yes, I plan to fix the one in busybox eventually...)

Rob


