Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWAOAz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWAOAz1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 19:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWAOAz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 19:55:27 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:41224 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751567AbWAOAz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 19:55:26 -0500
Date: Sat, 14 Jan 2006 19:54:45 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (other issues)
Message-ID: <20060115005442.GA32206@tuxdriver.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213237.GH16166@tuxdriver.com> <20060113222408.GM16166@tuxdriver.com> <43C97693.7000109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C97693.7000109@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 05:09:23PM -0500, Jeff Garzik wrote:
> John W. Linville wrote:
> >Other Issues
> >============
> 
> A big open issue:  should you fake ethernet, or represent 802.11 
> natively throughout the rest of the net stack?
> 
> The former causes various and sundry hacks, and the latter requires that 
> you touch a bunch of non-802.11 code to make it aware of a new frame class.

I had this entry in the "compatibility" section:

We need to be an 802.11 stack (i.e. drivers need to handle 802.11
frames).  Ethernet emulation is bound to paint us into a corner
eventually (if it hasn't already)

My opinion is that we need to 'bite the bullet' and make the kernel
aware of 802.11.  I figure we can leverage some existing work by
davem and acme for this.

John
-- 
John W. Linville
linville@tuxdriver.com
