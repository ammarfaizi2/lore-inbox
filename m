Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVL0R2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVL0R2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 12:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVL0R2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 12:28:08 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:12885 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751128AbVL0R2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 12:28:03 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [PATCH] USB_BANDWIDTH documentation change
Date: Tue, 27 Dec 2005 09:02:06 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>,
       Bodo Eggert <7eggert@gmx.de>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0512262244480.22764@be1.lrz> <Pine.LNX.4.44L0.0512261731001.10595-100000@netrider.rowland.org> <20051227041747.GA23916@kroah.com>
In-Reply-To: <20051227041747.GA23916@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512270902.07144.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 December 2005 8:17 pm, Greg KH wrote:
> 
> I just saw (but can't find again, sorry) a gentoo bug of an external usb
> driver on x86-64 that oopses _unless_ this config option is set.  So for
> some people it is necessary and not broken.

USB should never overcommit.  IMO the right answer is to remove the option
and always check.  And also remove the old usb_check_bandwidth() call, which
doesn't even have an accurate model for that reservation.

- Dave

