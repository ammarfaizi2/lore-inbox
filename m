Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWFYCn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWFYCn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 22:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWFYCn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 22:43:26 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:23750 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751353AbWFYCnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 22:43:25 -0400
Subject: Re: [linux-pm] [PATCH] get USB suspend to work again on 2.6.17-mm1
From: Jim Gettys <jg@laptop.org>
Reply-To: jg@laptop.org
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>, Mattia Dongili <malattia@linux.it>,
       Jiri Slaby <jirislaby@gmail.com>, linux-pm@osdl.org,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200606222034.44085.david-b@pacbell.net>
References: <20060622202952.GA14135@kroah.com>
	 <200606221624.03182.david-b@pacbell.net> <20060622235112.GA30484@kroah.com>
	 <200606222034.44085.david-b@pacbell.net>
Content-Type: text/plain
Organization: OLPC
Date: Sat, 24 Jun 2006 22:42:57 -0400
Message-Id: <1151203377.15365.389.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 20:34 -0700, David Brownell wrote:

> Under what scenario could it possibly be legitimate to suspend a
> usb device -- or interface, or anything else -- with its children
> remaining active?  The ability to guarantee that could _never_ happen
> was one of the fundamental motivations for the driver model ...
> 

I'm not sure this directly applies, but....

The Marvell wireless chip we're using this generation in the OLPC
machine is interfaced via USB.  Not ideal, but there's no other game in
town to let us keep the mesh network up while the main machine is STR.

We intend to leave the Marvell chip on (it can forward packets in the
mesh network, and/or wake up the CPU if there are inbound packets for
the machine that matter), and turn off the USB interface it is attached
to.
                        Regards,
                             - Jim

-- 
Jim Gettys
One Laptop Per Child


