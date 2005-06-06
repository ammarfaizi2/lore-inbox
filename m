Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVFFXdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVFFXdx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVFFXTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:19:37 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:2149 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261724AbVFFXCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:02:22 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [uml-devel] [PATCH 3/5] UML - Clean up tt mode remapping of UML binary
Date: Tue, 7 Jun 2005 01:05:19 +0200
User-Agent: KMail/1.7.2
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org>
In-Reply-To: <200506062008.j56K89YA008957@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506070105.20422.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 June 2005 22:08, Jeff Dike wrote:
> From Al Viro - this turns the tt mode remapping of the binary into arch
> code.
NACK at all, definitely, don't apply this one please. This patch:

1) On i386 does not fix the problem it was supposed to fix when I originately 
sent the first version (i.e. avoiding to create a .thread_private section to 
allow linking against NPTL glibc). It's done on x86_64 and forgot on i386.
2) Splitting the linker script for subarchs is definitely not needed.
3) This removes the fix (done through objcopy -G switcheroo) to a link time 
conflict happening on some weird glibc combinations.

I'll merge this work when it's ready.
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com
