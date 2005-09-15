Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030519AbVIOQVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030519AbVIOQVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030518AbVIOQVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:21:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24758 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030513AbVIOQVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:21:33 -0400
Date: Thu, 15 Sep 2005 09:21:45 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: jes@trained-monkey.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] hippi: change to not use skb private
Message-ID: <20050915092145.4ea4d069@dxpl.pdx.osdl.net>
In-Reply-To: <20050914.210316.32480446.davem@davemloft.net>
References: <20050913113858.440d3a0f@localhost.localdomain>
	<20050914.210316.32480446.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 1.9.14 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005 21:03:16 -0700 (PDT)
"David S. Miller" <davem@davemloft.net> wrote:

> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Tue, 13 Sep 2005 11:38:58 -0700
> 
> > It looks like the following would fix hippi to not have to put
> > fields in sk_buff. The ifield looks appears to to be additional
> > header information that is being passed in the skb but could just
> > be put in the header.
> 
> Stephen this patch is against 2.6.13 or something.  We already
> put this thing into a SKB control block for 2.6.14-rc1.  Do you
> want to keep things that way or update your patch for 2.6.14-rc1?

Sorry, I was cleaning up the old unfinished work pile. The new version
(using header) is better than the cb version because it is cleaner
and doesn't have the nasty error handling issues of reallocating
header in the transmit routine.
