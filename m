Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318623AbSGZXVx>; Fri, 26 Jul 2002 19:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318627AbSGZXVx>; Fri, 26 Jul 2002 19:21:53 -0400
Received: from deborah.paradise.net.nz ([203.96.152.32]:4869 "EHLO
	deborah.paradise.net.nz") by vger.kernel.org with ESMTP
	id <S318623AbSGZXVw>; Fri, 26 Jul 2002 19:21:52 -0400
Message-ID: <3D41DA4E.B243E55E@paradise.net.nz>
Date: Sat, 27 Jul 2002 11:25:02 +1200
From: Jens Schmidt <j.schmidt@paradise.net.nz>
X-Mailer: Mozilla 4.61 [en] (OS/2; U)
X-Accept-Language: en-GB,en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Bill Davidsen <davidsen@tmr.com>, Daniel Phillips <phillips@arcor.de>,
       Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code
References: <Pine.LNX.3.95.1020726100704.2003A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all,
I am not a "morse" guy myself, but appreciate this idea.
Here is what I dug out, (Google and my handbooks)

 International Morse Code

   Letter Morse     Letter Morse    Digit Morse
   A      .-        N      -.       0     -----
   B      -...      O      ---      1     .----
   C      -.-.      P      .--.     2     ..---
   D      -..       Q      --.-     3     ...--
   E      .         R      .-.      4     ....-
   F      ..-.      S      ...      5     .....
   G      --.       T      -        6     -....
   H      ....      U      ..-      7     --...
   I      ..        V      ...-     8     ---..
   J      .---      W      .--      9     ----.
   K      -.-       X      -..-
   L      .-..      Y      -.--
   M      --        Z      --..

   Punctuation Mark       Morse
   Full-stop (period)     .-.-.-
   Comma                  --..--
   Question mark (query)  ..--..
   Hyphen (-)             -....-
   Fraction bar (/)       -..-.
   Double dash (=)        -...-

   (less common)
   Brackets (parentheses) -.--.-
   Quotation marks        .-..-.
   Colon                  ---...
   Apostrophe             .----.

   Procedure codes
   Commence transmission  -.-.-   (CT)
   Wait                   .-...   (AS)
   End of message         .-.-.   (AR)
   End of work            ...-.-  (SK)
   The procedure codes are sent as a single character

  If the duration of a dot is taken to be one unit then
  that of a dash is three units.
  The space between the components of one character is one
  unit, between characters is three units and between
  words seven units.
  To indicate that a mistake has been made and for the
  receiver to delete the last word send ........ (eight dots).

Regards (73) Jens    ZL2TJT



"Richard B. Johnson" wrote:

> On Fri, 26 Jul 2002, Bill Davidsen wrote:
>
> > On Fri, 26 Jul 2002, Daniel Phillips wrote:
> >
> > > On Thursday 25 July 2002 14:51, Bill Davidsen wrote:
> > > > On Fri, 19 Jul 2002, Alan Cox wrote:
> > > >
> > > > > > +static const char * morse[] = {
> > > > > > +     ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", /* A-H */
> > [...snip...]
> > > > >
> > > > > How about using bitmasks here. Say top five bits being the length, lower
> > > > > 5 bits being 1 for dash 0 for dit ?
> > > >
> > > > ??? If the length is 1..5 I suspect you could use the top two bits and fit
> > > > the whole thing in a byte. But since bytes work well, use the top three
> > > > bits for length without the one bit offset. Still a big win over strings,
> > > > although a LOT harder to get right by eye.
> > >
> > > Please read back through the thread and see how 255 different 7 bit codes
> > > complete with lengths can be packed into 8 bits.
> >
> > ???
> >  1 - there are not 255 different 7 bit values, there are 128
> >  2 - morse code has a longest value of 5 elements not 7
>
> The '.' (also called full-stop) is 6 elements long. The ',' is also
> 6 elements long. For a correct implimentation, i.e., one that sounds
> correct, you need to encode a 'pause' element into each symbol. This
> is because the pause between Morse characters is sometimes ahead
> of a character and sometimes behind a character (the pause is ahead
> of characters starting with a dot and after characters ending with a
> dot, including characters of all dots -- except for numbers, which
> have pauses after them). In a previously life, I had to develop
> the correct "fist" to pass the Socond Class Radio Telegraph License.
>
> This means that it is probably best to use one 8-byte character
> for each Morse-code character.
>
> If anybody's interested I have some DOS assembly circa 1987 that
> did this stuff. It ignored the correct "fist", and has spaces after
> each character. It doesn't sound too bad.
>
> >  3 - Alan was talking about len+val representation, not stop-bit patterns,
> >      which is what I guess you mean
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> The US military has given us many words, FUBAR, SNAFU, now ENRON.
> Yes, top management were graduates of West Point and Annapolis.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

