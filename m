Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWEOKAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWEOKAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 06:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWEOKAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 06:00:15 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:64086 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751135AbWEOKAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 06:00:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=UpT+RUPZ90ZK4ziqpfiidMnkQhiFCyRTF03jhGGWfZ9Mm/zsnvP+nOzv2TzRm0NzSyo5rKAEjmDowqhShuNrflu9GHEgSxwFiyYaYEClKNbJ2t7o68cY+lnA45doHOV47P0W03hDmoCM5tp8Utxqvor+cNoK+kbY7btGGdC9mg8=  ;
Message-ID: <44685123.7040501@yahoo.com.au>
Date: Mon, 15 May 2006 20:00:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@csn.ul.ie>,
       davej@codemonkey.org.uk, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and free_area_init_nodes
References: <20060508141030.26912.93090.sendpatchset@skynet>	<20060508141211.26912.48278.sendpatchset@skynet> <20060514203158.216a966e.akpm@osdl.org> <44683A09.2060404@shadowen.org>
In-Reply-To: <44683A09.2060404@shadowen.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:

> Interesting.  You are correct there was no config component, at the time
> I didn't have direct evidence that any architecture needed it, only that
> we had an unchecked requirement on zones, a requirement that had only
> recently arrived with the changes to free buddy detection.  I note that

Recently arrived? Over a year ago with the no-buddy-bitmap patches,
right? Just checking because I that's what I'm assuming broke it...

> MAX_ORDER is 17 for ia64 so that probabally accounts for the
> missalignment.  It is clear that the reporting is slightly over-zelous
> as I am reporting zero-sized zones.  I'll get that fixed and patch to
> you.  I'll also have a look at the patch as added to -mm and try and get
> the rest of the spelling sorted :-/.
> 
> I'll go see if we currently have a machine to test this config on.


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
