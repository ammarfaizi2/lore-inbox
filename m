Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbUJ1C7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbUJ1C7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 22:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUJ1C7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 22:59:34 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:24239 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262725AbUJ1C7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 22:59:32 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
Date: Wed, 27 Oct 2004 21:59:29 -0500
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>
References: <200410271553_MC3-1-8D4F-38E7@compuserve.com> <1098913229.7783.2.camel@localhost.localdomain>
In-Reply-To: <1098913229.7783.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410272159.29831.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 04:40 pm, Alan Cox wrote:
> On Mer, 2004-10-27 at 20:50, Chuck Ebbert wrote:
> > On Wed, 27 Oct 2004 at 16:27 +0100 Alan Cox wrote:
> > > You missed the remote DoS attack 8(
> >   Where?
> 
> Posted to netdev along with fixes. See 2.6.9-ac1 or later
> 
> > >>   - i8042 fails to initialize with some boards using legacy USB
> > >
> > > This is really a BIOS issue and its not a new 2.6.9 bug its a long
> > > standing and messy story.
> > 
> >   And the patch in -ac fixes it but there is a cleaner one around
> > that does it more properly, right?
> 
> The -ac fix handles one corner case. The right fix appears to be to
> always disable USB legacy. But for a small fix its mighty risky.
>

I really wonder why is it risky? 99% of the time USB is loaded eventually
and does handoff anyway. What is the problem doing it earlier? Ones who
indeed use USB in legacy mode will have to boot with "no-handoff". I think
if you look at the numbers people using USB in legacy mode is a fraction
of a percent.

Plus, now we suggest disabling legacy emulation in BIOS which is problematic
if one wants to use USB keyboard in boot loader... Automatic handoff will
help here.

-- 
Dmitry
