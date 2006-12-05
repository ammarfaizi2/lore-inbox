Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937463AbWLEHCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937463AbWLEHCd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 02:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937464AbWLEHCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 02:02:33 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:34444 "HELO
	smtp102.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937463AbWLEHCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 02:02:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jV1tMXPPt3AVIY/WtelD/Ids0MVuyNqvpMyBfMQungBP7qpLiYwekZl8IS8yx8u7uu3wI99rCKp5o+0Lqk8QGy2/LzdwgxfVmOnfgbWHzsXFIdT/gcxOWA61frHSRu79uqZE48+Bsxuto9B5PRGPlgHDEY74FCGGC6ehR5x9jKU=  ;
X-YMail-OSG: vOpTolsVM1lHYy56SQGqwEcv5x_dwri8ev1Lw6b.03r2sOYU8P_UhSiFnhOseozvphUqB_xMNTIylMZoIlG2NbpZrM6ui02Lu8zTsCzqYExHLdtBswevlPXujqw7avGwDlIkXdk85xaHT48-
Message-ID: <45751955.8010506@yahoo.com.au>
Date: Tue, 05 Dec 2006 18:01:41 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aucoin@Houston.RR.com
CC: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: la la la la ... swappiness
References: <200612050641.kB56f7wY018196@ms-smtp-06.texas.rr.com>
In-Reply-To: <200612050641.kB56f7wY018196@ms-smtp-06.texas.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aucoin wrote:
>>From: Linus Torvalds [mailto:torvalds@osdl.org]
>>I actually suspect you should be _fairly_ close to such a situation
> 
> 
> We run with min_free_kbytes set around 4k to answer your earlier question.
> 
> 
>>Louis, exactly how do you allocate that big 1.6GB shared area?
> 
> 
> Ummm, shm_open, ftruncate, mmap ? Is it a trick question ? The process
> responsible for initially setting up the shared area doesn't stay resident.

The issue is that the shm pages should show up in the active and
inactive lists. But they aren't, and you seem to have about 1542524K
unacconted for. Weird.

Can you try getting the output of /proc/vmstat as well?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
