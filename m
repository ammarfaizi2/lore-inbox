Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbTDKTAu (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbTDKTAu (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:00:50 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:56326 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261488AbTDKTAs (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 15:00:48 -0400
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain
	backward compatibility
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andries.Brouwer@cwi.nl
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, pbadari@us.ibm.com
In-Reply-To: <UTC200304111807.h3BI7Or07403.aeb@smtp.cwi.nl>
References: <UTC200304111807.h3BI7Or07403.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Apr 2003 14:12:18 -0500
Message-Id: <1050088340.1750.205.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-11 at 13:07, Andries.Brouwer@cwi.nl wrote:
> It is just that Badari and I were talking about the numbering scheme
> index = next_index++ and he pointed out that the current system
> has a certain weak number preservation guarantee that this
> index = next_index++ does not have. True.

Yes. I was just pointing out this was a byproduct of our compaction
requirement in 8:8, not necessarily a guarantee I think needs
preserving.

> It is me who wants compatibility as far as 8+8 device numbers are
> concerned, while I can see lots of ways to use new number space.

This, I'm not too sure about.  I see the value to kernel developers who
boot between different versions of the kernel, but I think when 2.6 goes
live and ships to end users, it's better not to have such numeric
equivalency crufting up the SCSI interfaces.

James


