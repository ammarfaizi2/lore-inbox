Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316782AbSGZEtT>; Fri, 26 Jul 2002 00:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSGZEtT>; Fri, 26 Jul 2002 00:49:19 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:19098 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316782AbSGZEtS>; Fri, 26 Jul 2002 00:49:18 -0400
Message-ID: <032001c23460$2f59e340$1125a8c0@wednesday>
From: "jdow" <jdow@earthlink.net>
To: "Daniel Phillips" <phillips@arcor.de>, "Bill Davidsen" <davidsen@tmr.com>
Cc: "Andrew Rodland" <arodland@noln.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020725084540.11202C-100000@gatekeeper.tmr.com> <E17Xw0V-0004f8-00@starship>
Subject: Re: [PATCH -ac] Panicking in morse code
Date: Thu, 25 Jul 2002 21:52:03 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel Phillips" <phillips@arcor.de>

> On Thursday 25 July 2002 14:51, Bill Davidsen wrote:
> > On Fri, 19 Jul 2002, Alan Cox wrote:
> >
> > > > +static const char * morse[] = {
> > > > + ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", /* A-H */
> > > > + "..", ".---.", "-.-", ".-..", "--", "-.", "---", ".--.", /* I-P */
> > > > + "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", /* Q-X */
> > > > + "-.--", "--..", /* Y-Z */
> > > > + "-----", ".----", "..---", "...--", "....-", /* 0-4 */
> > > > + ".....", "-....", "--...", "---..", "----." /* 5-9 */
> > >
> > > How about using bitmasks here. Say top five bits being the length,
lower
> > > 5 bits being 1 for dash 0 for dit ?
> >
> > ??? If the length is 1..5 I suspect you could use the top two bits and
fit
> > the whole thing in a byte. But since bytes work well, use the top three
> > bits for length without the one bit offset. Still a big win over
strings,
> > although a LOT harder to get right by eye.
>
> Please read back through the thread and see how 255 different 7 bit codes
> complete with lengths can be packed into 8 bits.

It appears someone is under the misapprehension that Morse characters are
all 5 elements or less. "SK" is an example of a six element meta-character,
one of a set that needs caring for, "...-.-".

(Gawd I wish I could forget that silly communications mode. <sigh>)

{^_^}    W6MKU (Color me a spread-spectrum maven.)

