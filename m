Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932857AbWFME12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857AbWFME12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932863AbWFME12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:27:28 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:5774 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932857AbWFME12 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:27:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OH3/nGaJ7CNoyvTUtiSW+VsTSWsp4T7U7DEkCyb2ArxjrZyCMcp3zx1S9ILyCbVwLVqhL4EsjpLvvm77LIP/FEI2fhVxqWZ9gO5FdHixuGpdk6TZWksZdQdlQrhuHp7zseyXC8nPuYymDVDNMUGhSrM/bQKTnz+1J/tiTWEeKlg=  ;
Message-ID: <448E3EA8.3020807@yahoo.com.au>
Date: Tue, 13 Jun 2006 14:27:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: rohitseth@google.com, Andrew Morton <akpm@osdl.org>, Linux-mm@kvack.org,
       Linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of physical
 pages backing it
References: <1149903235.31417.84.camel@galaxy.corp.google.com> <200606121958.41127.ak@suse.de> <1150141369.9576.43.camel@galaxy.corp.google.com> <200606130551.23825.ak@suse.de>
In-Reply-To: <200606130551.23825.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>On Monday 12 June 2006 21:42, Rohit Seth wrote:
>
>>I think having this 
>>information in each vma keeps the impact (of adding new counter) to very
>>low.
>>
>>Second question is to advertize this value to user space.  Please let me
>>know what suites the most among /proc, /sys or system call (or if there
>>is any other mechanism then let me know) for a per process per segment
>>related information.
>>
>
>I think we first need to identify the basic need.
>Don't see why we even need per VMA information so far.
>

Exactly. There is no question that walking page tables will be slower
than having a counter like your patch does; the question is why we
need it.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
