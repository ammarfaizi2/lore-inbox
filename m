Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSJDMWu>; Fri, 4 Oct 2002 08:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSJDMWu>; Fri, 4 Oct 2002 08:22:50 -0400
Received: from hq.alert.sk ([147.175.66.131]:37795 "EHLO hq.alert.sk")
	by vger.kernel.org with ESMTP id <S261573AbSJDMWs>;
	Fri, 4 Oct 2002 08:22:48 -0400
Date: Fri, 4 Oct 2002 14:28:17 +0200
From: Robert Varga <nite@hq.alert.sk>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
Message-ID: <20021004122817.GA30205@hq.alert.sk>
References: <OF6E4A0115.7A4BB6D7-ON85256C47.0059EE6F@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6E4A0115.7A4BB6D7-ON85256C47.0059EE6F@pok.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 12:42:23PM -0500, Mark Peloquin wrote:
> >> +static inline int
> >> +list_member(struct list_head *member)
> >> +{
> >> +  return ((!member->next || !member->prev) ? FALSE : TRUE);
> >> +}
> 
> > This should go into list.h
> 
> Yes it should. I will pull this out of this header
> and submit a patch for list.h.

Possibly shortened to:

static inline int list_member(struct list_head *member)
{
	return member->next && member->prev;
}

Faster, and (at least to me) it looks more obvious.

-- 
Kind regards,
Robert Varga
------------------------------------------------------------------------------
n@hq.sk                                          http://hq.sk/~nite/gpgkey.txt
