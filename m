Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281559AbRKUNyW>; Wed, 21 Nov 2001 08:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281381AbRKUNyM>; Wed, 21 Nov 2001 08:54:12 -0500
Received: from wallext.webflex.nl ([212.115.150.250]:57279 "EHLO
	palm.webflex.nl") by vger.kernel.org with ESMTP id <S281050AbRKUNx5>;
	Wed, 21 Nov 2001 08:53:57 -0500
Message-ID: <XFMail.20011121145237.mathijs@knoware.nl>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20011121143738.D2196@artax.karlin.mff.cuni.cz>
Date: Wed, 21 Nov 2001 14:52:37 +0100 (CET)
From: Mathijs Mohlmann <mathijs@knoware.nl>
To: Jan Hudec <bulb@ucw.cz>
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Nov-2001 Jan Hudec wrote:
>> Go read up on C operator precedence. Unary ++ comes before %, so if we
>> rewrite the #define to make it more "readable" it would be #define
>> MODINC(x,y) (x = (x+1) % y)
> 
> *NO* 
> MODINC(x,y) (x = (x+1) % y)
> is correct and beaves as expected. Unfortunately:
> MODINC(x,y) (x = x++ % y)
> is a nonsence, because the evaluation is something like this
> x++ returns x
> x++ % y returns x % y
> x is assigned the result and it's incremented IN UNDEFINED ORDER!!!
> AFAIK the ANSI C spec explicitly undefines the order.

in fact, gcc does (according to my tests):
MODINC(x,y) (x = (x % y) + 1)



-- 
        me
