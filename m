Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVHAJ2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVHAJ2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 05:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVHAJ2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 05:28:23 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:36686 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262042AbVHAJ1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 05:27:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=BuzUnp6ElT8Dxuu301Jy8W5LOzyRZMQEu0SIC3RxtZ6vJ9/1cQ3/6H/2TqRc44Xp+FDJJS1ultV2qNQhv/CtAwrRWqwjRY+flpZsOvFYW5DXnfuD95RuShbrdY2NN9PQmjnjDiusLhTU6MA3RQdR4ZLDYhuf8DcZl9WKl+OGlyg=  ;
Message-ID: <42EDEAFE.1090600@yahoo.com.au>
Date: Mon, 01 Aug 2005 19:27:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Roland McGrath <roland@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
References: <20050801032258.A465C180EC0@magilla.sf.frob.com> <42EDDB82.1040900@yahoo.com.au> <20050801091956.GA3950@elte.hu>
In-Reply-To: <20050801091956.GA3950@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>Feedback please, anyone.
> 
> 
> it looks good to me, but wouldnt it be simpler (in terms of patch and 
> architecture impact) to always retry the follow_page() in 
> get_user_pages(), in case of a minor fault? The sequence of minor faults 

I believe this can break some things. Hugh posted an example
in his recent post to linux-mm (ptrace setting a breakpoint
in read-only text). I think?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
