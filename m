Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSIYJns>; Wed, 25 Sep 2002 05:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261951AbSIYJns>; Wed, 25 Sep 2002 05:43:48 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:32784 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261950AbSIYJns>; Wed, 25 Sep 2002 05:43:48 -0400
Subject: Re: Polling /proc/apm causes usb hiccups and clock drift
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: jstrand1@rochester.rr.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1032947264.15722.9.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.7 
Date: 25 Sep 2002 05:48:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James D Strandboge <jstrand1@rochester.rr.com> wrote:
> polling /proc/apm causes the webcam in xawtv to skip.
> [...]
> Is this a kernel apm bug or BIOS problem?

The apm driver calls the APM BIOS with interrupts disabled
each time /proc/apm is read.  This appears to be taking
too much time away from video processing.




__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
