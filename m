Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbTDKUDq (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTDKUDq (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:03:46 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:10500 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261719AbTDKUDB (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 16:03:01 -0400
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain
	backward compatibility
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andries.Brouwer@cwi.nl
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, pbadari@us.ibm.com
In-Reply-To: <UTC200304111945.h3BJjU409008.aeb@smtp.cwi.nl>
References: <UTC200304111945.h3BJjU409008.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Apr 2003 15:14:32 -0500
Message-Id: <1050092073.2078.219.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-11 at 14:45, Andries.Brouwer@cwi.nl wrote:
> I think compatibility is very important.
> Linux does not arbitrarily break old systems. The aim must be
> to have all combinations of (old/new) kernel with (old/new) glibc
> to work well in all situations where old kernel + old glibc worked.

Well, if you're going to do this, at least make it possible to tie all
the sd devices to a single major (i.e. the numeric compatibility layer
simply maps to the new single major scheme internally).  It would also
be nice for numeric compatibility to be a compile time option too...

It's also possible that SCSI may not be the only consumer of such a
compatibility layer (IDE also has multiple majors), so it may be
worthwhile putting it somewhere more globally useful (like
fs/block_dev.c)

James


