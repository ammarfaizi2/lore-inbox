Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUFSDtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUFSDtY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 23:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265785AbUFSDtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 23:49:24 -0400
Received: from mail022.syd.optusnet.com.au ([211.29.132.100]:19886 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265768AbUFSDtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 23:49:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: 2.6.7-ck1
Date: Sat, 19 Jun 2004 13:48:57 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <200406162122.51430.kernel@kolivas.org> <1087576093.2057.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1087576093.2057.1.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406191348.57383.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004 02:28, Felipe Alfaro Solana wrote:
> On Wed, 2004-06-16 at 21:22 +1000, Con Kolivas wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Patchset update. The focus of this patchset is on system responsiveness
> > with emphasis on desktops, but the scope of scheduler changes now makes
> > this patch suitable to servers as well.
>
> I've found some interaction problems between, what I think it's, the
> staircase scheduler and swsusp. With vanilla 2.6.7, swsusp is able to
> save ~9000 pages to disk in less than 5 seconds, where as 2.6.7-ck1
> takes more than 1 minute to save the same amount of pages when
> suspending to disk.

If you're using -ck1 it may even be the autoswappiness. Try disabling that and 
setting a static value for swappiness. If it still exhibits the problem then 
it's probably a bug somewhere in staircase. While the overall design is 
finished (it doesn't really lend itself to tuning), surely there are bugs I 
haven't sorted out even though there are no serious bugs or stability issues 
that have come up. I'm auditing the code as we speak.

Thanks.
Con
