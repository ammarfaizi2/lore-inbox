Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbUB2TUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 14:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUB2TUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 14:20:11 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:23448 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S262108AbUB2TUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 14:20:07 -0500
Subject: Re: Linux 2.6 Build System and Binary Modules
From: Larry Reaves <larry@moonshinecomputers.com>
To: Robbert Haarman <lkml@inglorion.net>
Cc: kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040229183143.GA8057@shire.sytes.net>
References: <20040229183143.GA8057@shire.sytes.net>
Content-Type: text/plain
Message-Id: <1078082400.3942.21.camel@tux.moonshinecomputers.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 29 Feb 2004 14:20:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to do exactly the same thing... unfortunately I have not had
much success getting it to work.  I have, however, solved your problem. 
What I did was 'touch -B 9999999 priv_part.c' which creates an empty
file with a timestamp of the current time minus 9999999 seconds. 
Because make will only recompile if the source is newer than the .o, it
will assume it is already compiled and it will just link it in.  I am
new to kernel development, so I haven't made much progress beyond
getting the module to compile without errors.  If you are able to get it
to work, please let me know.

On Sun, 2004-02-29 at 13:31, Robbert Haarman wrote:
> Hello list,
> 
> Excuse me for not finding this if it has been asked before. Please Cc any answers, as I am not subscribed to this list.
> 
> I am trying to port a driver for the Realtek 8180 wireless ehternet controller from 2.4 to 2.6. The module comes as a binary-only object file with some sources that can be adapted to fit the specific kernel. My problem is that I can't figure out how to get the 2.6 kernel to include the binary part (it's in a .o file). The new build system does a little too much magic - compiling the module from source to .ko without giving me a chance to sneak in the binary code. How do I get it to link in the .o file, without making it look for the like-named .c file?
> 
> Cheers,
> 
> Robbert Haarman
> 
> ---
> "UNIX was not designed to stop you from doing stupid things, because that
> would also stop you from doing clever things."
> 	--Doug Gwyn
-- 
Larry Reaves <larry@moonshinecomputers.com>

