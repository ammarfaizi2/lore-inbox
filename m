Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267522AbTAGS7s>; Tue, 7 Jan 2003 13:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267521AbTAGS7s>; Tue, 7 Jan 2003 13:59:48 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:57439 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id <S267517AbTAGS7r>; Tue, 7 Jan 2003 13:59:47 -0500
Message-ID: <3E1B25A2.7020508@users.sf.net>
Date: Tue, 07 Jan 2003 20:08:18 +0100
From: Thomas Tonino <ttonino@users.sf.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Asterisk] DTMF noise
References: <20030107140012$1b66@gated-at.bofh.it> <20030107150006$4896@gated-at.bofh.it>
In-Reply-To: <20030107150006$4896@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Spencer wrote:

> The DTMF detector in the linux kernel is fairly simplistic and doesn't do
> many relative energy tests.  The Zapata library has a much better tone
> detector, but it is FP, and so would have to be made fixed point.  If
> nothing else, it may provide some lessons for the ISDN folks.

I remember that a good DTMF decoder can be very simplistic: DTMF was designed 
for that.

The idea is:

- separate the high tones from the low tones.
- amplify clip the high band and the low band separately
- run the tone decoders on the clipped signals

The clipping stage would make sure that only relatively pure tones will trigger 
the detector.

See also http://groups.google.com/groups?selm=7462%40accuvax.nwu.edu


Thomas

