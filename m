Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271857AbRH1R2r>; Tue, 28 Aug 2001 13:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271861AbRH1R2i>; Tue, 28 Aug 2001 13:28:38 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:22210 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S271860AbRH1R22>;
	Tue, 28 Aug 2001 13:28:28 -0400
Message-ID: <3B8BD4CB.3D885FC6@linux-m68k.org>
Date: Tue, 28 Aug 2001 19:28:43 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
CC: Andreas Schwab <schwab@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108280617250.8365-100000@penguin.transmeta.com> <3B8BA883.3B5AAE2E@linux-m68k.org> <je4rqsdv4z.fsf@sykes.suse.de> <3B8BCB1B.9C4B35C0@linux-m68k.org> <20010828131229.G9945@ead45>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Bill Rugolsky Jr." wrote:

> > Ok, it uses an assignment, but it has almost the same effect (except for
> > pointer/integer values).
> 
> Wrong.  A cast throws away information, making meaningful warnings impossible.
> The assignment allows the compiler to apply the usual C integral
> promotions and catch narrowing and non-value-preserving conversions,
> like unsigned int to int, or an even more common bug, unsigned int to
> long, which behaves differently depending on whether long is 32 or 64
> bits.

Do you have an example? AFAIK this can only be done for constants and
mosts constants used with min are within usual integer limits.

bye, Roman
