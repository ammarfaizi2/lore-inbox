Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285410AbRLNQwQ>; Fri, 14 Dec 2001 11:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285412AbRLNQwH>; Fri, 14 Dec 2001 11:52:07 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:32266 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S285410AbRLNQv4>; Fri, 14 Dec 2001 11:51:56 -0500
Message-ID: <3C1A0130.EE7CEE1A@cyclades.com>
Date: Fri, 14 Dec 2001 10:40:00 -0300
From: Daniela Squassoni <daniela@cyclades.com>
Organization: Cyclades
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.4.9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
CC: Krzysztof Halasa <khc@intrepid.pm.waw.pl>,
        Fran?ois Romieu <romieu@cogenit.fr>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: dscc4 and new Generic HDLC Layer
In-Reply-To: <3C19CA22.E604CB32@cyclades.com> <20011214151518.B30306@xyzzy.org.uk>
Content-Type: multipart/mixed;
 boundary="------------3C480A56DCD50085DD622E01"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3C480A56DCD50085DD622E01
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bob Dunlop wrote:
> 
> I'm confused.  How was the patch generated ?   How should I apply it ?
> 
> The patch repeats some of Krzystofs changes so I can't apply it over the
> top of his patch but at the same time it doesn't include the changes for
> FarSite, SBE Inc or you own Cyclades cards.  Better to have a patch that
> brings all the drivers up to spec in one hit surely.

This patch was done against the kernel 2.4.17-pre8. All the drivers that
are using the HDLC layer in the kernel source tree have been included.
The farsync.c does not even call the register_hdlc_device routine... 

Let's fix what is already in the kernel source tree first, and then we
can include what is missing (e.g. the PC300 driver and others that
provide separate patches for the HDLC layer), right?!

> 
> Probably too late to get API changes into 2.4.x, but we should get the
> generic HDLC layer into 2.5.x ASAP IMHO.  Then you might be able to argue
> for a backport into 2.4.x in the future.

Why doing that if it is ready for 2.4.x?!
The patch that I've just sent doesn't bring anything really new. It just
fixes what is wrong in the current version. Am I missing something here?

> 
> > I am waiting for the inclusion of these changes in the kernel for months
> > to submmit the PC300 driver, and this delay is causing me troubles,
> > customers complainings, etc.
> 
> Tell me about it :-)  FarSite are having to maintain an extra set of patches
> for customers who need the functionality of the generic layer.
That is exactly what I have to do...

Best regards,

Daniela
--------------3C480A56DCD50085DD622E01
Content-Type: text/x-vcard; charset=us-ascii;
 name="daniela.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Daniela Squassoni
Content-Disposition: attachment;
 filename="daniela.vcf"

begin:vcard 
n:Squassoni;Daniela
x-mozilla-html:FALSE
org:Cyclades;R&D
adr:;;;;;;
version:2.1
email;internet:daniela@cyclades.com
title:Software Engineer
x-mozilla-cpt:;-3392
fn:Daniela Squassoni
end:vcard

--------------3C480A56DCD50085DD622E01--

