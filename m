Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbVI0VAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbVI0VAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbVI0VAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:00:48 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43182 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932523AbVI0VAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:00:47 -0400
Message-ID: <4339B2F6.1070806@austin.ibm.com>
Date: Tue, 27 Sep 2005 16:00:38 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: haveblue@us.ibm.com, mrmacman_g4@mac.com, akpm@osdl.org,
       lhms-devel@lists.sourceforge.net, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, mel@csn.ul.ie, kravetz@us.ibm.com
Subject: Re: [Lhms-devel] Re: [PATCH 1/9] add defrag flags
References: <4338537E.8070603@austin.ibm.com>	<43385412.5080506@austin.ibm.com>	<21024267-29C3-4657-9C45-17D186EAD808@mac.com>	<1127780648.10315.12.camel@localhost>	<20050926224439.056eaf8d.pj@sgi.com>	<433991A0.7000803@austin.ibm.com> <20050927123055.0ad9c2b4.pj@sgi.com>
In-Reply-To: <20050927123055.0ad9c2b4.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Once this is merged with current Linux, which already has GFP_HARDWALL,
> I presume you will be back up to 21 bits, code and comment.

Looks like it.

> 
> As I noted in another message the "USER" and the comment in:
> 
> #define __GFP_USER	0x40000u /* User is a userspace user */
> 
> are a bit misleading now.  Perhaps GFP_EASYRCLM?
> 

A rose by any other name would smell as sweet -Romeo

A flag by any other name would work as well -Joel

There are problems with any name we would use.  I personally like __GFP_USER 
because it is mostly user memory, and nobody will accidently use it to label 
something that is not user memory.  Those who do use it for non-user memory will 
do so with more caution and ridicule.  This will keep it from expanding in use 
beyond its intent.

If we name it __GFP_EASYRCLM we then start getting into questions about what we 
mean by easy and somebody is going to  decide that their kernel memory is pretty 
easy to reclaim and mess things up.  Maybe we could call it 
__GPF_REALLYREALLYEASYRCLM to avoid confusion.

If there is a consensus from multiple people for me to go rename the flag 
__GFP_xxxxx then I'm not that attached to it and will.  But for now I'm going to 
leave it __GFP_USER.
