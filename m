Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267546AbTAGWht>; Tue, 7 Jan 2003 17:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTAGWht>; Tue, 7 Jan 2003 17:37:49 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:32787 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id <S267546AbTAGWhr>; Tue, 7 Jan 2003 17:37:47 -0500
Date: Tue, 7 Jan 2003 23:46:19 +0100
Subject: Re: [Asterisk] DTMF noise
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v551)
Cc: linux-kernel <linux-kernel@vger.kernel.org>
To: Thomas Tonino <ttonino@users.sourceforge.net>
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
In-Reply-To: <3E1B25A2.7020508@users.sf.net>
Message-Id: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.551)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The DTMF detector in the linux kernel is fairly simplistic and 
>> doesn't do
>> many relative energy tests.  The Zapata library has a much better tone
>> detector, but it is FP, and so would have to be made fixed point.  If
>> nothing else, it may provide some lessons for the ISDN folks.
>
> I remember that a good DTMF decoder can be very simplistic: DTMF was 
> designed for that.
>
> The idea is:
>
> - separate the high tones from the low tones.
> - amplify clip the high band and the low band separately
> - run the tone decoders on the clipped signals
>
> The clipping stage would make sure that only relatively pure tones 
> will trigger the detector.
>
> See also http://groups.google.com/groups?selm=7462%40accuvax.nwu.edu

but the problem here, is just what you're describing.

The DTMF decoder is finding DTMF signals in normal speech, so talking 
with someone with Asterisk (dot org) using isdn4linux is a true 
nightmare. Linux's DTMF detector finds DTMF signals all the time, 
making asterisk signal them as sounds.

so - we DO NOT need a 'simplistic' DTMF decoder. not for this purpose, 
that is

roy

