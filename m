Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUJ3JcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUJ3JcE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 05:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbUJ3JcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 05:32:04 -0400
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:4103 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S263664AbUJ3Jaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 05:30:55 -0400
Message-ID: <41835F4D.2060508@tebibyte.org>
Date: Sat, 30 Oct 2004 11:30:53 +0200
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com> <20041028120650.GD5741@logos.cnet> <41824760.7010703@tebibyte.org> <41834FE7.5060705@jp.fujitsu.com> <418354C0.3060207@tebibyte.org> <418357C5.4070304@jp.fujitsu.com>
In-Reply-To: <418357C5.4070304@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hiroyuki KAMEZAWA escreveu:
> zone->free_area[order]->nr_free is corrupted, this patch fix it.
> 
> It looks there is no area->nr_free++ code during freeing pages, now.

It's corrupt because area is out of scope at that point - it's declared 
within the for loop above.

Should I move your fix into the loop or move the declaration of area to 
function scope?

Regards,
Chris R.
