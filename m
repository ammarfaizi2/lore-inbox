Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSHWKCR>; Fri, 23 Aug 2002 06:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318726AbSHWKCR>; Fri, 23 Aug 2002 06:02:17 -0400
Received: from mail.iok.net ([62.249.129.22]:20230 "EHLO mars.iok.net")
	by vger.kernel.org with ESMTP id <S317359AbSHWKCQ>;
	Fri, 23 Aug 2002 06:02:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Holger Schurig <h.schurig@mn-logistik.de>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: cell-phone like keyboard driver anywhere?
Date: Fri, 23 Aug 2002 12:05:28 +0200
User-Agent: KMail/1.4.3
References: <200208210932.36132.h.schurig@mn-logistik.de> <200208230954.11132.h.schurig@mn-logistik.de> <20020823103151.A19858@flint.arm.linux.org.uk>
In-Reply-To: <20020823103151.A19858@flint.arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
X-Archive: encrypt
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208231205.28764.h.schurig@mn-logistik.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problems that need to be resolved with the kernel approach.  Lets
> look at the '1-1-1' case:
>
> 1. Do you queue the characters "a" "^h" "b" "^h" "c" ?

There is no '1-1-1' case, the case is '1-1-1-pause'. Only after the pause 
would the software (may it be kernel or user-space) know that and what 
character has been meant. At the '1-1-1' state the user might press again a 1 
and then wait, then this might be an '1-pause' case.


The idea is that in the case of '1-1-1-pause' the driver queues exactly one 
character, e.g. the "c".

> 2. How do you handle the case where the app is waiting for one key press
>    only, but the user hits '1' three times?

See 1. The app doesn't see that this key has been hit three times.

> 3. what if the app doesn't want to accept another character into (say)
>    a text field?  The effect of "a" "^h" "b" will always replace the last
>    character.

When the driver would send Backspaces, then yes. Otherwise not.


So we both agree that sending backspaces from a cell-phone-like keyboard 
driver is a bad thing :-)

