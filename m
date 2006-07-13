Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWGMPov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWGMPov (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWGMPov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:44:51 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:60070 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1030239AbWGMPou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:44:50 -0400
Message-ID: <44B66A70.90502@oracle.com>
Date: Thu, 13 Jul 2006 08:44:48 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Xavier Roche <roche+kml2@exalead.com>
CC: linux-kernel@vger.kernel.org, linux-aio <linux-aio@kvack.org>
Subject: Re: io_submit() taking a long time to return ?
References: <44B5ED5F.1040606@exalead.com>
In-Reply-To: <44B5ED5F.1040606@exalead.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> By reading the aio documentation, we expected the io_submit call to
> always return immediately,

Sadly, that isn't guaranteed.

> but in our preliminary tests we noticed that
> sometimes this call can take a long time (more than 10 ms, even
> sometimes more than 30 ms !!).

If I had to guess I'd suspect that these delays are due to sync block
mapping lookups in the submit path.  Do these tend to show up the first
time you read a file?

- z
