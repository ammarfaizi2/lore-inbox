Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422741AbWG2KhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbWG2KhK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 06:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422744AbWG2KhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 06:37:10 -0400
Received: from web36908.mail.mud.yahoo.com ([209.191.85.76]:50552 "HELO
	web36908.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422740AbWG2KhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 06:37:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VMPdJWsVN8IVppnxtHJGNT8+0DUZbccYoByLZPKuJQV5RDph+3NdH4DzijekIupqUgSMXXfx78MZy0xi20oGlxC5i5Lma6Us5atOZpM6ZD8Lq2Dgay/MYd5f+iH7QZp/XoohyYMSwhSJk2hh31B7iTTV6EdhcsRtAkVKP+hMXQ0=  ;
Message-ID: <20060729103707.26737.qmail@web36908.mail.mud.yahoo.com>
Date: Sat, 29 Jul 2006 11:37:07 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: Generic battery interface
To: Shem Multinymous <multinymous@gmail.com>,
       "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Shem Multinymous <multinymous@gmail.com> wrote:

> On 7/29/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> > On Sat, 29 Jul 2006 01:10:40 +0300, Shem Multinymous said:
> > > On 7/28/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> > > > Is there a reliable (or hack-worthy) way for the kernel to determine how
> > > > often the values are re-posted by the hardware?
> > >
> > > That's hardware-specific. Some drivers can know, others may just
> > > assume 1sec or 0.1sec or whatever.
> >
> > That smells suspiciously like "We need an API for the hardware-specific
> > bits f code to pass the generic bits a value for this..." (and the
> > hardware-specific part can either ask the battery, or return a
> > hard-coded "10 seconds" that somebody measured, or whatever)....
> 
> I don't think "update frequency" is a good abstraction. The hardware's
> update may not be variable and irrregular (e.g., event-based), and
> there's there's an issue of phase sync to avoid unnecessary latency.
> 
> The lazy polling approach I described in my last post to Vojtech
> ("block until there's  a new readout or N milliseconds have passed,
> whichever is later") looks like a more general, accurate and efficient
> interface.
> 

This sounds like a good idea. You could do a similar thing using sysfs by
providing a entry in sysfs which tells userland when the next update is going
to happen, the userland app can then decide to use this as it's next poll time
or not.

Mark

>   Shem
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
Yahoo! Photos – NEW, now offering a quality print service from just 7p a photo http://uk.photos.yahoo.com
