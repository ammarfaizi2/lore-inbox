Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbVLGGFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbVLGGFp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 01:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbVLGGFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 01:05:45 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:63674 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932661AbVLGGFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 01:05:44 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Date: Wed, 7 Dec 2005 01:05:39 -0500
User-Agent: KMail/1.8.3
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
References: <20051205212337.74103b96.khali@linux-fr.org> <20051205202707.GH15201@flint.arm.linux.org.uk>
In-Reply-To: <20051205202707.GH15201@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512070105.40169.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 15:27, Russell King wrote:
> On Mon, Dec 05, 2005 at 09:23:37PM +0100, Jean Delvare wrote:
> > The name parameter of platform_device_register_simple should be of
> > type const char * instead of char *, as we simply pass it to
> > platform_device_alloc, where it has type const char *.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> However, I've been wondering whether we want to keep this "simple"
> interface around long-term given that we now have a more flexible
> platform device allocation interface - I don't particularly like
> having superfluous interfaces for folk to get confused with.

Now that you made platform_device_alloc install default release
handler there is no need to have the _simple interface. I will
convert input devices (main users of _simple) to the new interface
and then we can get rid of it.

-- 
Dmitry
