Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVCOQRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVCOQRB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVCOQP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:15:57 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24038 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261378AbVCOQO5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:14:57 -0500
Subject: Re: [Ext2-devel] Re: [PATCH] 2.6.11-mm3 patch for ext3 writeback
	"nobh" option
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20050314180917.07f7ac58.akpm@osdl.org>
References: <1110827903.24286.275.camel@dyn318077bld.beaverton.ibm.com>
	 <20050314180917.07f7ac58.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1110902996.24286.328.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Mar 2005 08:09:57 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 18:09, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > Here is the 2.6.11-mm3 version of patch for adding "nobh"
> >  support for ext3 writeback mode.
> 
> Care to update Documentation/filesystems/ext3.txt?

Yes. I will do that. I am planning to add "nobh" support to
ext3 ordered mode also, since its the default one. We need
to modify generic interfaces like mpage_writepage(s) to
keep track of bio count and make journal code wait for them etc. -
at that point the "generic" code will no longer be generic.
I am thinking of a way to do it *less* intrusively. 

At that point, we can make "nobh" default option. (which
needs less documentation).

> 
> >  Can you include it in -mm ?
> 
> Spose so.
> 
> Did you have performance and resource consumption numbers to justify it?  I
> think I asked that before and promptly forgot the answer, which is a good
> reason for taking some care over changelog maintenance...

The initial numbers showed 5-7% throughput improvements. I will send out
resource consumption numbers once I complete my regression tests.

Yep. I will update the changelog also.


Thanks,
Badari

