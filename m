Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288736AbSBSTDb>; Tue, 19 Feb 2002 14:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285589AbSBSTDL>; Tue, 19 Feb 2002 14:03:11 -0500
Received: from mario.gams.at ([194.42.96.10]:19974 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S288614AbSBSTC7> convert rfc822-to-8bit;
	Tue, 19 Feb 2002 14:02:59 -0500
Message-Id: <200202191902.g1JJ2wx28246@frodo.gams.co.at>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hex <-> int conversion routines. 
In-Reply-To: <02021919493204.00447@jakob> 
In-Reply-To: Your message of "Tue, 19 Feb 2002 19:49:32 +0100."
             <02021919493204.00447@jakob> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Tue, 19 Feb 2002 20:02:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Kemi <jakob.kemi@telia.com> wrote:
>> > +static __inline__ char inthex_nibble(int x)
>> > +{
>> > +	const char* digits = "0123456789abcdef";
>> > +
>> > +	return digits[x & 0x0f];
>> > +}
>>
>> perhaps better do static const char *digits.
>GCC doesn't copy const strings, as opposed to other const arrays.
>So it should be fine as it is. GCC also reuse duplicated strings.

You could also do
    return "0123456789abcdef"[x & 0x0f];
though some will find it bad, ugly, wrong
or make a file-global
    static const char digits[] = "0123456789abcdef";

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


