Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272133AbTG2VsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272143AbTG2VsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:48:18 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:44273 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S272133AbTG2VsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:48:13 -0400
Date: Tue, 29 Jul 2003 23:47:05 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.0-test2 loses time on 486
Message-ID: <20030729214705.GA24743@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
References: <200307291734.h6THYhmp012585@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307291734.h6THYhmp012585@harpo.it.uu.se>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 07:34:43PM +0200, Mikael Pettersson wrote:
> My old 486 test box is losing time at an alarming rate
> when running 2.6.0-test kernels. It loses almost 2 minutes
> per hour, less if it sits idle. This problem does not
> occur when it's running a 2.4 kernel.

I recently saw a patch to compensate for the 1000/1024 ratio,
HZ being 1000 nowadays. I'm not sure if it is already in test2.
It wasn't in test1. There is a similar compensation for 100/128
in case HZ == 100. Search for HZ == 100 in kernel/timer.c in
second_overflow()

I'm not sure what this fix does does but 2 minutes per hour is close to
1000/1024 ratio.

-- 
Frank
