Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUGMGZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUGMGZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 02:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUGMGZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 02:25:58 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:30442 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261638AbUGMGZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 02:25:57 -0400
Subject: Re: [PATCH] Making i/dhash_entries cmdline work as it use to.
From: Dave Hansen <haveblue@us.ibm.com>
To: "Jose R. Santos" <jrsantos@austin.ibm.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       slpratt@us.ibm.com
In-Reply-To: <20040713023721.GA7461@austin.ibm.com>
References: <20040712175605.GA1735@rx8.austin.ibm.com>
	 <20040713023721.GA7461@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1089699910.19847.13357.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Jul 2004 23:25:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 19:37, Jose R. Santos wrote:
> * Jose R. Santos <jrsantos@austin.ibm.com> [2004-07-12 12:56:05 -0500]:
> > Also, any particular reason why MAX_SYS_HASH_TABLE_ORDER was set to 14?
> > I am already seeing the need to go higher on my 64GB setup and was 
> > wondering if this could be bumped up to 19.
> 
> Actualy, it doesnt look like we need MAX_SYS_HASH_TABLE_ORDER at all so
> I'm resending the patch which now limits the max size of a hash table to
> 1/16 total memory pages.  This would keep people from doing dangerous
> things when using the hash_entries.

Do you worry that you're just expanding the hash table as long as it
gives benefit on your one, single benchmark?  There have to be plenty of
other workloads that could benefit from an extra 1/16th more memory. 
Not every workload is as dcache heavy as SFS.  

-- Dave

