Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWBRUPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWBRUPG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 15:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWBRUPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 15:15:06 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:1324 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932139AbWBRUPF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 15:15:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k9z0zKQZ1bsyX5drdCHzAVVh0ooGwupryUaDxvQ80q7ZsLU9XJ1CtHrDaKWu/qsgneX4vryPVMpAkyZ+TgmfraBCj1lTjxqONmx8wQMnaSHbO/yr5EvlYi1QoyhmhRGl4ZxbiGMBno1IOL9zGQcgp1Sgq3Yu4IPNa+JxiLMKsYw=
Message-ID: <a36005b50602181215u73d73336m34f6a1cbbabd2236@mail.gmail.com>
Date: Sat, 18 Feb 2006 12:15:03 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Bernd Eckenfels" <be-news06@lina.inka.de>
Subject: Re: How to find the CPU usage of a process
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1FAXjn-0001V7-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a36005b50602181055n454c446aoed83ea21baaf1a67@mail.gmail.com>
	 <E1FAXjn-0001V7-00@calista.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/06, Bernd Eckenfels <be-news06@lina.inka.de> wrote:
> But thats only for yourself, right?

In that abbreviated form, yes.

To get an arbitrary process' time use

  clockid_t cl;
  clock_getcpuclockid(pid, &cl);
  struct timespec ts;
  clock_gettime(cl, &ts);

This is all documented in POSIX.
