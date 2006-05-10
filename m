Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWEJAPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWEJAPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 20:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWEJAPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 20:15:30 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:5747 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751015AbWEJAP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 20:15:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=K4SXDMh1f0N5okMphaYeoHE+2+aYrfmCAsDFQfbZoOlX8wc9Jbz3h0emE/emeymo5A7c3zVd0fMhNJGT7IPWHh3mtA1B7HCf+hGKgoGjqwvGDJ+ox9w+qoJzAmWQbSO0E7W5dFJwF3dVWbpfvwMqHnblMcuZWGLcsEH9xVNK9yE=  ;
Message-ID: <44613099.4020502@yahoo.com.au>
Date: Wed, 10 May 2006 10:15:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, jlan@engr.sgi.com
Subject: Re: [Patch 2/8] Sync block I/O and swapin delay collection
References: <20060502061408.GM13962@in.ibm.com> <20060508141952.2d4b9069.akpm@osdl.org> <20060509035320.GC784@in.ibm.com> <44601933.2040905@yahoo.com.au> <20060509054556.GG784@in.ibm.com> <44602F32.1060909@yahoo.com.au> <20060509080638.GB11533@in.ibm.com> <446050BC.5070608@yahoo.com.au> <20060509172716.GB10478@in.ibm.com>
In-Reply-To: <20060509172716.GB10478@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> On Tue, May 09, 2006 at 06:20:12PM +1000, Nick Piggin wrote:

>>So... what are the consumers of this data going to be? That is my question.
> 
> 
> More details on the consumers of this data is available at
> http://lkml.org/lkml/2006/3/13/367

Profiling, monitoring, and control (workload management).

Sounds like something that at the moment, most users and most
applications will not use, most of the time.

I won't question the usefulness of the statistics to some
applications, but at the moment is it is reasonable to add this
overhead for everyone, or even for all tasks? Adding a bit more
work for those that want the stats won't be too bad.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
