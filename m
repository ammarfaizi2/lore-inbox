Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbUJYNZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUJYNZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUJYNZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:25:09 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:5048 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261794AbUJYNY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:24:28 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Date: Mon, 25 Oct 2004 08:22:46 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200410210154.58301.dtor_core@ameritech.net> <20041025125629.GF6027@crusoe.alcove-fr>
In-Reply-To: <20041025125629.GF6027@crusoe.alcove-fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410250822.46023.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 07:56 am, Stelian Pop wrote:
> On Thu, Oct 21, 2004 at 01:54:58AM -0500, Dmitry Torokhov wrote:
> 
> > I have been looking at the sysdevs in present in the kernel and noticed that
> > sonypi was registering itself as a system device. Surely it is possible to
> > suspend it with interrupyts enabled, so it better be converted to a platform
> > device. I course of convert I also did some additional changes:
> [...]
> 
> Thanks for those patches and sorry for the lack of response, I was out
> of town for the last week.
> 
> I have quite a few changes in my tree already for the sonypi driver,
> and I was delaying the submission because I need to solve a problem
> with the integration with the input subsystem...
>

If you need a hand - I am a bit familiar with the input system...
 
> Some of your changes (those related to module_param(), wait_event()
> use etc) were already in my tree, those related to whitespace cleanup,
> platform instead of sysdev etc are new and I will integrate them.
>

The change from sysdev to a platform device is the main reason I did
the change (and getting rid of old pm_register stuff which is useless
now) because swsusp2 (and seems that swsusp1 as well) have trouble
resuming system devices. The rest was just fluff really.

-- 
Dmitry
