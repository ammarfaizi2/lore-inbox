Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVLAQJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVLAQJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVLAQJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:09:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932289AbVLAQJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:09:47 -0500
Date: Thu, 1 Dec 2005 08:09:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mark Lord <lkml@rtr.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix bytecount result from printk()
In-Reply-To: <438F1D05.5020004@rtr.ca>
Message-ID: <Pine.LNX.4.64.0512010808240.3099@g5.osdl.org>
References: <438F1D05.5020004@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Dec 2005, Mark Lord wrote:
> 
> On a related note, WHY does the LOG LEVEL format <6> not get
> interpreted correctly for the first printk() after an oops report?

It never gets interpreted except at the behinning of a line. Sounds like 
the oops report perhaps prints a " " without a newline or something at the 
end, so that the next message after that isn't a new line?

		Linus
