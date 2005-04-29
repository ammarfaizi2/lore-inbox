Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVD2XXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVD2XXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 19:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbVD2XXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 19:23:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:33532 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262470AbVD2XXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 19:23:07 -0400
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: suparna@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <427280C1.8090404@us.ibm.com>
References: <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114207837.7339.50.camel@localhost.localdomain>
	 <1114659912.16933.5.camel@mindpipe>
	 <1114715665.18996.29.camel@localhost.localdomain>
	 <20050429135211.GA4539@in.ibm.com>  <427280C1.8090404@us.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 29 Apr 2005 16:22:59 -0700
Message-Id: <1114816980.10473.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 11:45 -0700, Badari Pulavarty wrote:
> I touch tested your patch earlier and seems to work fine. Lets integrate
> Mingming's getblocks() patches with this and see if we get any benifit
> from the whole effort.
> 

I tried Suparna's mpage_writepages_getblocks patch with my
ext3_get_blocks patch, seems to work fine,  except that still only one
block is allocated at a time. I got a little confused.... 

I did not see any delayed allocation code in your patch, I assume you
have to update ext3_prepare_write to not call ext3_get_block, so that
block allocation will be defered at ext3_writepages time. So without the
delayed allocation part, the get_blocks in mpage_writepages is doing
multiple blocks look up only, right?


Mingming

