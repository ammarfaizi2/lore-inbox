Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWFNOe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWFNOe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWFNOe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:34:59 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58561 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964977AbWFNOe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:34:58 -0400
Subject: Re: SO_REUSEPORT and multicasting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jason <bofh1234567@yahoo.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060614142653.71443.qmail@web53606.mail.yahoo.com>
References: <20060614142653.71443.qmail@web53606.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Jun 2006 15:51:07 +0100
Message-Id: <1150296668.3490.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-14 am 07:26 -0700, ysgrifennodd Jason:
> > Have you bound to a multicast group in your program?
> 
> If BSD supports it why can't Linux?  

Linux follows the standards draft.  SO_REUSEPORT is fairly obscure
BSDism.

> Yes.  My code works great on HP-UX but does nothing on
> Linux.  

That doesn't actually prove very much. Its very easy to write incorrect
code that only works on one system, especially when endian-ness gets
involved with network code.

In particular if writing portable code you must remember to join the
group. You must also remember that the various htons/htonl macros need
to be correctly used or your code will break on little-endian systems.

The default IP_MULTICAST_LOOP value is probably also worth overriding if
you are being fairly paranoid.


