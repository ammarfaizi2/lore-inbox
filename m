Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752384AbWCRIao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbWCRIao (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 03:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbWCRIao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 03:30:44 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:51356 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751949AbWCRIan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 03:30:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wef7Ef6n9hMu6l7thpUU9UmIKRXYUd39OzBaHUftzZsLpG96QEoIINLWMWvTpUMVJG84B5hVuq98TYGKgDwnEXvdpHHKN63BWCseGnKxeJDg22PNhaP+MvYE+biFqvXRXxBF2eCjget0KNbW6ce/nBnWn0fJVEFSGqcijlVcsNE=  ;
Message-ID: <441BC527.50400@yahoo.com.au>
Date: Sat, 18 Mar 2006 19:30:31 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, ck@vds.kolivas.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Stefan Seyfried <seife@suse.de>, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH][RFC] mm: swsusp shrink_all_memory tweaks
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603181556.23307.kernel@kolivas.org> <441B9E5A.1040703@yahoo.com.au> <200603181714.23977.kernel@kolivas.org>
In-Reply-To: <200603181714.23977.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> cc'ed GregKH for comment hopefully.

>>You did the right thing there by introducing the accessor, which moves the
>>ifdef out of code that wants to query the member right? But you can still
>>leave it in the .c file if it is local (which it is).
> 
> 
> Once again I'm happy to do the right thing; I'm just not sure what that is.
> 

Well, struct scan_control escaping from vmscan.c is not the right thing
(try to get that past Andrew!). Obviously in this case, having the ifdef
in the .c file is OK.

I guess Greg's presentation is a first order approximation to get people
thinking in the right way. I mean we do it all the time, and in core kernel
code too (our favourite sched.c is a prime example).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
