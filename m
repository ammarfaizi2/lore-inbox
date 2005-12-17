Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbVLQQnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbVLQQnF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 11:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbVLQQnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 11:43:05 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:20581 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932603AbVLQQnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 11:43:02 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Input: fix an OOPS in HID driver
Date: Sat, 17 Dec 2005 11:40:27 -0500
User-Agent: KMail/1.8.3
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200512162131.04544.dtor_core@ameritech.net> <20051217102223.GB27280@midnight.suse.cz>
In-Reply-To: <20051217102223.GB27280@midnight.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512171140.28029.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 December 2005 05:22, Vojtech Pavlik wrote:
> On Fri, Dec 16, 2005 at 09:31:04PM -0500, Dmitry Torokhov wrote:
> > Subject: 
> > 
> > This patch fixes an OOPS in HID driver when connecting simulation
> > devices generating unknown simulation events.
> > 
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> Yup, needed indeed. I'm not sure if we want an 'unknown': 'ignore'
> might be safer.

Well, 'unknown' restores the previous behavior (before simulation codes
were added to the driver) so it is pretty safe, however 'ignore' is indeed
more correct I think.

I will send an updated patch. Linus, if you already applied the original
one just ignore the new one - we can change it post 2.6.15 when we add
more simulation codes to HID driver.

-- 
Dmitry
