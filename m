Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVCDAsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVCDAsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVCDAo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:44:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65471 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262724AbVCDAll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:41:41 -0500
Message-ID: <4227AEA2.8060007@pobox.com>
Date: Thu, 03 Mar 2005 19:41:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][16/26] IB/mthca: mem-free doorbell record writing
References: <2005331520.WW3zbnVIUjZ4q0Ov@topspin.com>	<4227A606.50703@pobox.com> <52vf88ntbo.fsf@topspin.com>
In-Reply-To: <52vf88ntbo.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Jeff> Are you concerned about ordering, or write-combining?
> 
> ordering... write combining would be fine.
> 
>     Jeff> I am unaware of a situation where writes are re-ordered into
>     Jeff> a reversed, descending order for no apparent reason.
> 
> Hmm... I've seen ppc64 do some pretty freaky reordering but on the
> other hand that's a 64-bit arch so we don't care in this case.  I
> guess I'd rather keep the barrier there so we don't have the
> possibility of a rare hardware crash when the HCA just happens to read
> the doorbell record in a corrupt state.

Well, we don't just add code to "hope and pray" for an event that nobody 
is sure can even occur...

Does someone have a concrete case where this could happen?  ever?

	Jeff


