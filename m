Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289806AbSBSGbO>; Tue, 19 Feb 2002 01:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289839AbSBSGaz>; Tue, 19 Feb 2002 01:30:55 -0500
Received: from wet.kiss.uni-lj.si ([193.2.98.10]:21010 "EHLO
	wet.kiss.uni-lj.si") by vger.kernel.org with ESMTP
	id <S289806AbSBSGat>; Tue, 19 Feb 2002 01:30:49 -0500
Content-Type: text/plain;
  charset="iso-8859-2"
From: Rok =?iso-8859-2?q?Pape=BE?= <rok.papez@kiss.uni-lj.si>
Reply-To: rok.papez@kiss.uni-lj.si
To: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Re: Communication between two kernel modules
Date: Mon, 18 Feb 2002 19:30:02 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <20020218173229.47247.qmail@web14907.mail.yahoo.com>
In-Reply-To: <20020218173229.47247.qmail@web14907.mail.yahoo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <02021819300201.00953@strader.home>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael!

On Monday 18 February 2002 18:32, Michael Zhu wrote:

> Hi, how can I call some kind of APIs from kernel mode,
> such as open, ioctl and close? Because I need to use
> some services of another kernel module from my kernel
> module and I have no source code of the module which
> provides the services. Now I can only access the
> module in user space using the open, ioctl and close
> APIs. Can I do the same thing in my kernel module?
> Thanks.

Create a user-space app that will ioctl into your driver and wait for 
requests. When your module needs to call the other module it delivers request 
to the user-space app wich in turn calls the other module and returns results 
via another ioctl call.

Take care not to deadlock.. In user space app use fork() or threads and 
handle module requests async...

Be ready to handle an event when your user-space app unexpectedly dies.

-- 
best regards,
Rok Pape¾.
