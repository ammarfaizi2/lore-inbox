Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUBDHLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 02:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266299AbUBDHLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 02:11:12 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:61060 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266296AbUBDHLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 02:11:11 -0500
Subject: Re: Active Memory Defragmentation: Our implementation & problems
From: Dave Hansen <haveblue@us.ibm.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: Alok Mooley <rangdi@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040204065717.EFB277049E@sv1.valinux.co.jp>
References: <20040204050915.59866.qmail@web9704.mail.yahoo.com>
	 <1075874074.14153.159.camel@nighthawk>
	 <20040204065717.EFB277049E@sv1.valinux.co.jp>
Content-Type: text/plain
Organization: 
Message-Id: <1075878652.14155.416.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Feb 2004 23:10:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-03 at 22:57, IWAMOTO Toshihiro wrote:
> At 03 Feb 2004 21:54:34 -0800,
> Dave Hansen wrote:
> > Moving file-backed pages is mostly handled already.  You can do a
> > regular page-cache lookup with find_get_page(), make your copy,
> > invalidate the old one, then readd the new one.  The invalidation can be
> > done in the same style as shrink_list().
> 
> Actually, it is a bit more complicated.
> I have implemented similar functionality for memory hotremoval.
> 
> See my post about memory hotremoval
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107354781130941&w=2
> for details.
> remap_onepage() and remapd() in the patch are the main functions.

remap_onepage() is quite a function.  300 lines.  It sure does cover a
lot of ground. :)

Defragmentation is a bit easier than removal because it isn't as
mandatory.  Instead of having to worry about waiting on things like
writeback, the defrag code can just bail.  

--dave

