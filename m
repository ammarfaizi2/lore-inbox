Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261938AbREQPnA>; Thu, 17 May 2001 11:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261946AbREQPmk>; Thu, 17 May 2001 11:42:40 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:42702 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S261938AbREQPmb>; Thu, 17 May 2001 11:42:31 -0400
Message-ID: <3B03EE1E.5A050E1B@TeraPort.de>
Date: Thu, 17 May 2001 17:28:30 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Bjorn Wesen <bjorn@sparta.lu.se>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: make menuconfig - cosmetic question
In-Reply-To: <Pine.LNX.3.96.1010517151441.14658A-100000@medusa.sparta.lu.se>
Content-Type: multipart/mixed;
 boundary="------------B1A6F03F4A93850C2548DEA5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B1A6F03F4A93850C2548DEA5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bjorn Wesen wrote:
> 
> While we're on cosmetics... how about imprisonment for the person who
> chose yellow on light grey for the first letters in each option...
> 
> /Bjorn
> 
> On Thu, 17 May 2001, Martin.Knoblauch wrote:
> >  this is most likely just a small issue. If I knew where to look, I
> > would try to fix it and submit a patch :-)
> >
> >  When I diff config files pocessed by "make [old]config" and "make
> > menueconfig", it seems that menuconfig is not writing out some of the
> > "comments" that the other versions do write. This is of course nothing
> > serious, but it ticks me off. Any idea where to look for this glitch?

 Now, changing that color is simple. Just change the value of TAG_KEY_FG
in scripts/lxdialog/colors.h. Unfortunatelly, this is not a question of
cosmetics, but taste. And I do not want to go into that :-)

 After some browsing around the Menuconfig script and not really
understanding how it works :-), I found the line to change. At least now
the config files look identical when processed with menuconfig (except
the fisrt comment, of course):

--- linux/Scripts/Menuconfig.orig     Thu May 17 17:19:21 2001
+++ linux/scripts/Menuconfig  Thu May 17 17:17:25 2001
@@ -1250,7 +1250,7 @@
        function comment () {
                if [ "$comment_is_option" ]
                then
-                       comment_is_option=
+                       comment_is_option=TRUE
                        echo        >>$CONFIG
                        echo "#"    >>$CONFIG
                        echo "# $1" >>$CONFIG

 Not sure whether this is worth to put into the next release - maybe
someone can spend two minutes to crosscheck.

Martin
PS: Sorry for the MIME. Should not have happend :-( Hope it is better
now.
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
IT Services              |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------B1A6F03F4A93850C2548DEA5
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

--------------B1A6F03F4A93850C2548DEA5--

