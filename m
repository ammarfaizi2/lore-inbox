Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTFIQKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 12:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTFIQKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 12:10:49 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:405 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264500AbTFIQKo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 12:10:44 -0400
Message-ID: <3EE4B543.3020104@pacbell.net>
Date: Mon, 09 Jun 2003 09:26:43 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, david+cert@blue-labs.org
Subject: Re: USB burps with irq XX: nobody cared. (2.5.70)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like a stream of IRQs getting delivered before
the chip was initialized ... interrupts that shouldn't
have been arriving.  Do you have funky BIOS settings?

Does this happen if you don't use ACPI?  I've had
reports of folk using NForce2 boards that needed
to use "acpi=off", since ACPI didn't initialize
the interrupts correctly.  Yours seems to be at
least partially correct.

- Dave

