Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWEUACf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWEUACf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 20:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWEUACf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 20:02:35 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:43605 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932230AbWEUACe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 20:02:34 -0400
Date: Sat, 20 May 2006 17:02:32 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ameer Armaly <ameer@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] initialize variables to reduce i386 warnings
Message-ID: <20060521000232.GC11232@taniwha.stupidest.org>
References: <Pine.LNX.4.61.0605201919100.2160@sg1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605201919100.2160@sg1>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 07:19:48PM -0400, Ameer Armaly wrote:

> Initialized cpu_freq in arch/i386/kernel/cpu/transmeta.c to suppress
> warning.

Urgh.

Doing this just to silence gcc is wrong.  I know we've done this at
times in the past and that's still not right (I would argue those
should be reverted even).

>  	struct range {
> -		unsigned long start;
> -		unsigned long end;
> +		unsigned long start = 0;
> +		unsigned long end = 0;

?
