Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTHWK2R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 06:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbTHWK2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 06:28:17 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:11432 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262540AbTHWK2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 06:28:15 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Sat, 23 Aug 2003 12:28:13 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: TeJun Huh <tejun@aratech.co.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race condition in 2.4 tasklet handling (cli() broken?)
Message-Id: <20030823122813.0c90e241.skraw@ithnet.com>
In-Reply-To: <20030823052633.GA4307@atj.dyndns.org>
References: <20030823025448.GA32547@atj.dyndns.org>
	<20030823040931.GA3872@atj.dyndns.org>
	<20030823052633.GA4307@atj.dyndns.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003 14:26:34 +0900
TeJun Huh <tejun@aratech.co.kr> wrote:

>  Oops, Sorry.  Only bh handling is relevant.  Softirq and tasklet are
> not of concern to cli().
> 
> On Sat, Aug 23, 2003 at 01:09:31PM +0900, TeJun Huh wrote:
> >  Additional suspicious things.
> > 
> > 1. tasklet_kill() has similar race condition.  mb() required before
> > tasklet_unlock_wait().
> 
> Corrected 2.
> [...]
>  If bh hanlding is not guaranteed to be blocked during cli() - sti()
> critical section, global_bh_lock test inside wait_on_irq() is
> redundant and if it should be guaranteed, current implmentation seems
> broken.

If we follow your analysis and say it is broken, do you have a suggestion/patch
how to fix both? I am willing to try your proposals, as it seems I am one of
very few who really experience stability issues on SMP with the current
implementation.

Regards,
Stephan
