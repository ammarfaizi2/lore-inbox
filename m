Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUHSUFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUHSUFo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUHSUFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:05:44 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:61285 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267345AbUHSUFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:05:33 -0400
Date: Fri, 20 Aug 2004 00:05:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: GNU make alleged of "bug" (was: PATCH: cdrecord: avoiding scsi device numbering for ide devices)
Message-ID: <20040819220553.GC7440@mars.ravnborg.org>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200408191600.i7JG0Sq25765@tag.witbe.net> <200408191341.07380.gene.heskett@verizon.net> <20040819194724.GA10515@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819194724.GA10515@merlin.emma.line.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 09:47:24PM +0200, Matthias Andree wrote:
> # BEGIN Makefile
> all:    hello
> hello.d:
>         makedepend -f- hello.c >$@
> include hello.d
> # END Makefile
> 
> You'll get at "make" time:
> 
> Makefile:5: hello.d: No such file or directory
> makedepend -f- hello.c >hello.d
> cc   hello.o   -o hello
> 
> and a working hello program.

Using:
-include hello.d
will result in a silent make.

	Sam
