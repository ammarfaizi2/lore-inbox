Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316747AbSGZDl3>; Thu, 25 Jul 2002 23:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSGZDl3>; Thu, 25 Jul 2002 23:41:29 -0400
Received: from dsl-213-023-043-040.arcor-ip.net ([213.23.43.40]:27355 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316747AbSGZDl3>;
	Thu, 25 Jul 2002 23:41:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH -ac] Panicking in morse code
Date: Fri, 26 Jul 2002 05:43:09 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1020725084540.11202C-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020725084540.11202C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Xw0V-0004f8-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 July 2002 14:51, Bill Davidsen wrote:
> On Fri, 19 Jul 2002, Alan Cox wrote:
> 
> > > +static const char * morse[] = {
> > > +	".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", /* A-H */
> > > +	"..", ".---.", "-.-", ".-..", "--", "-.", "---", ".--.", /* I-P */
> > > +	"--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", /* Q-X */
> > > +	"-.--", "--..",	 	 	 	 	 	 /* Y-Z */
> > > +	"-----", ".----", "..---", "...--", "....-",	 	 /* 0-4 */
> > > +	".....", "-....", "--...", "---..", "----."	 	 /* 5-9 */
> > 
> > How about using bitmasks here. Say top five bits being the length, lower
> > 5 bits being 1 for dash 0 for dit ?
> 
> ??? If the length is 1..5 I suspect you could use the top two bits and fit
> the whole thing in a byte. But since bytes work well, use the top three
> bits for length without the one bit offset. Still a big win over strings,
> although a LOT harder to get right by eye.

Please read back through the thread and see how 255 different 7 bit codes
complete with lengths can be packed into 8 bits.

-- 
Daniel
