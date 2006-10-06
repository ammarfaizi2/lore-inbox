Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWJFUbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWJFUbO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWJFUbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:31:14 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:21064 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932591AbWJFUbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:31:13 -0400
Date: Fri, 6 Oct 2006 22:30:42 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Moore, Robert" <robert.moore@intel.com>, Andrew Morton <akpm@osdl.org>,
       Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] Cast removal
Message-ID: <20061006203042.GK14186@rhun.haifa.ibm.com>
References: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com> <20061006143555.GC14186@rhun.haifa.ibm.com> <Pine.LNX.4.61.0610062211220.30417@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0610062211220.30417@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 10:18:57PM +0200, Jan Engelhardt wrote:
 
> >IMHO there's another reason to do this which is much more relevant: it
> >tells the reader that whoever wrote it knows that it returns a value
> >and ignores it on purpose.
> 
> And GCC does not care about that, i.e. it still prints foritfy warnings, 
> as in:
> 
> $ svn co https://svn.sourceforge.net/svnroot/ttyrpld/trunk a && cd a
> $ make user/rpld.o EXT_CFLAGS="-D_FORTIFY_SOURCE=2"
> user/rpld.c:425: warning: ignoring return value of ‘write’, declared 
> with attribute warn_unused_result

Sure, if an interface is decalred with warn_unused_result gcc should
warn, even if the caller casts it to void. But in the normal case,
casting the result of the function to void tells the reader that you
know that it returns something, and you don't care.

Cheers,
Muli


