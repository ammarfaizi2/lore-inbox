Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135549AbREGIlt>; Mon, 7 May 2001 04:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132922AbREGIlj>; Mon, 7 May 2001 04:41:39 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:19707 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S135614AbREGIl1>; Mon, 7 May 2001 04:41:27 -0400
Message-ID: <3AF65FB3.777461BA@TeraPort.de>
Date: Mon, 07 May 2001 10:41:23 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [Solved ?] Re: pcmcia problems after upgrading from 2.4.3-ac7 to 2.4.4
In-Reply-To: <E14vFZb-0005GA-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------205B0FF206ADE27AAA9267B2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------205B0FF206ADE27AAA9267B2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> 
> >  my DE-620 pccard stopped working after upgrading the kernel from
> > 2.4.3-ac7 to 2.4.4. This is on a Toshiba 4080XCDT. I used the "good"
> > .config from the 2.4.3-ac7 build to do a make "oldconfig". The symptoms
> > at startup are:
> 
> 2.4.4 has older pcmcia than 2.4.3-ac7. It might be that. Does 2.4.4-ac work ?
Hi,

 after some experimenting, I found a solution that works for me. Looking
at the README-2.4 file for the pcmcia-cs package, I found that there is
a strong advice AGAINST using the i82365 module when runnung 2.4.x
kernels. Instead yenta_sockets should be specified. I changed that and
guess what - pcmcia is working again for me.

  I am not sure whether this should be closed alltogether. Maybe i82365
was not the proper choice for my hardware in the first place. Anyway,
the module seems to be retired as of 2.4.3-ac10/ac11. Maybe a hint
should go into the changes document.

Thanks for the patience
Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
IT Services              |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------205B0FF206ADE27AAA9267B2
Content-Type: text/x-vcard; charset=us-ascii;
 name="Martin.Knoblauch.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Martin.Knoblauch
Content-Disposition: attachment;
 filename="Martin.Knoblauch.vcf"

begin:vcard 
n:Knoblauch;Martin
tel;cell:+49-170-4904759
tel;fax:+49-89-510857-111
tel;work:+49-89-510857-309
x-mozilla-html:FALSE
url:http://www.teraport.de
org:TeraPort GmbH;IT-Services
adr:;;Garmischer Straße 4;München;Bayern;D-80339;Germany
version:2.1
email;internet:Martin.Knoblauch@TeraPort.de
title:Senior System Engineer
x-mozilla-cpt:;32160
fn:Martin Knoblauch
end:vcard

--------------205B0FF206ADE27AAA9267B2--

