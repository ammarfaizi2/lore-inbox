Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272476AbRH3VQ4>; Thu, 30 Aug 2001 17:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272474AbRH3VQs>; Thu, 30 Aug 2001 17:16:48 -0400
Received: from barnowl.demon.co.uk ([158.152.23.247]:34180 "EHLO
	barnowl.demon.co.uk") by vger.kernel.org with ESMTP
	id <S272475AbRH3VQd>; Thu, 30 Aug 2001 17:16:33 -0400
Mail-Copies-To: nobody
To: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108292018380.1062-100000@penguin.transmeta.com>
	<20010830165447Z16272-32385+540@humbolt.nl.linux.org>
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: Thu, 30 Aug 2001 21:16:47 +0000
In-Reply-To: <20010830165447Z16272-32385+540@humbolt.nl.linux.org> (Daniel
 Phillips's message of "Thu, 30 Aug 2001 19:01:25 +0200")
Message-ID: <m266b51c5c.fsf@barnowl.demon.co.uk>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> writes:

> More than anything, it shows that education is needed, not macro patch-ups.
> We have exactly the same issues with < and >, should we introduce 
> three-argument macros to replace them?

Would it not have been much more "obvious" if the rules for
unsigned/signed integer comparisons (irrespective of the widths
involved) were

1) If the signed element is negative then it is always less than the
   unsigned element.

2) If the unsigned element is greater than then maximum positive value
   expressible by the signed one then it is always greater.

3) Only if both values are positive and within the range of the
   smaller element are the actual values compared. 
