Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966257AbWKTRjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966257AbWKTRjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966267AbWKTRjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:39:14 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:10150 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S966257AbWKTRjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:39:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J9JLo57tQPtP+DOgoZZ8808cDpGgmVQAjg42yEqhom1lDLQ0yFs2ymATPG9nhFk5Wa2XaA+cw8s87dqxfhzPBOwIcXx9tdORaIqc7HZN85qAISS8xWBQENTD5jUdGgXrQ+dOSv5wDPTtwrzHSNITkPZ3UwEOqn8e+lPXF+bz6EE=
Message-ID: <395f05b00611200939n1bc81c77ue4e1ae78fc87b643@mail.gmail.com>
Date: Mon, 20 Nov 2006 09:39:03 -0800
From: "David Hinds" <dahinds@gmail.com>
To: "Tony Olech" <tony.olech@elandigitalsystems.com>,
       "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "Linux kernel development" <linux-kernel@vger.kernel.org>,
       "PCMCIA Maintainence" <linux-pcmcia@lists.infradead.org>,
       "David Hinds" <dahinds@users.sourceforge.net>,
       "Jaroslav Kysela" <perex@suse.cz>,
       "Bart Prescott" <bart.prescott@elandigitalsystems.com>
Subject: Re: [PATCH] PCMCIA identification strings for cards manufactured by Elan
In-Reply-To: <20061120172731.GC26791@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611201214.kAKCErcU005240@imap.elan.private>
	 <20061120130237.GA22330@flint.arm.linux.org.uk>
	 <1164032582.30853.36.camel@n04-143.elan.private>
	 <20061120152927.GA26791@flint.arm.linux.org.uk>
	 <1164041509.30853.48.camel@n04-143.elan.private>
	 <20061120172731.GC26791@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the SP230 is a special case (multifunction serial+parallel).
 You should look at the CIS for that card; it might not have a serial
function code at all.

-- Dave


On 11/20/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Mon, Nov 20, 2006 at 04:51:48PM +0000, Tony Olech wrote:
> > Hi Russell,
> > if I take out the patches to parport_cs and serial_cs,
> > leaving in only the patch to "pdaudiocf" our SP230 card
> > no longer works - it does not lock up the kernel, admittedly,
> > and the serial only card does works, but we would like
> > all are cards to just work.
>
> Sounds like function ID matching is broken.  Dominik?
>
> > ALSO, I have found no way to force a particular 16-bit
> > pcmcia card to be handled by a particular module in a
> > similar way to the USB generic serial driver module
> > parameter. Have I misssed the obvious? Or is that a
> > desirable feature that have been taken out of the David
> > Hinds original implementation?
>
> Again, Dominik's area of expertise.
>
> --
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
>
