Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTE0Ei7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTE0Ei7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:38:59 -0400
Received: from vitelus.com ([64.81.243.207]:12305 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S263340AbTE0Ei6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:38:58 -0400
Date: Mon, 26 May 2003 21:47:44 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] [Cool stuff] "checking" mode for kernel builds
Message-ID: <20030527044744.GJ9947@vitelus.com>
References: <20030527030219.GI9947@vitelus.com> <Pine.LNX.4.44.0305262009400.1680-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305262009400.1680-100000@home.transmeta.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 08:23:37PM -0700, Linus Torvalds wrote:
> Any takers? Some Makefile magic plus some hacky thing like
> 
> 	gcc -print-file-name=include
> 
> (Yeah, that's not righ either, it just happens to work. I don't know what
> the proper way of making gcc expose its local paths is).

gcc -v will tell you the final include path, but only when you
actually compile something. I'd probably make the makefile hackery parse
the ouput of echo | gcc -v -E -. Yeah, it's ugly.

The output between "#include <...> search starts here:" and "End of
search list." seems like the combination of what you want for
gcc_includepath and sys_includepath. I assume the output is ordered. I
might send a patch if I'm bored tonight.
