Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbTLDUzf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTLDUze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:55:34 -0500
Received: from main.gmane.org ([80.91.224.249]:45490 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262558AbTLDUz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:55:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Thu, 04 Dec 2003 21:55:23 +0100
Message-ID: <yw1xoeuos3pg.fsf@kth.se>
References: <200312041432.23907.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:OOiX37Ya2LK1h7UBTjmWTH9+kWU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <rob@landley.net> writes:

> You can make a file with a hole by seeking past it and never writing to that 
> bit, but is there any way to punch a hole in a file after the fact?  (I mean 
> other with lseek and write.  Having a sparse file as the result....)

I've never heard of one.

> What are the downsides of holes?  (How big do they have to be to
> actually save space, is there a performance penalty to having a file
> with 1000 4k holes in it, etc...)

A hole has to be at least the size of one block in the filesystem,
typically 4k, to save any space.  Regarding performance, I would
expect it to improve for reads.

-- 
Måns Rullgård
mru@kth.se

