Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVF1UDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVF1UDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVF1UCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:02:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20870 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261269AbVF1UCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:02:18 -0400
Date: Tue, 28 Jun 2005 13:01:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: shai@scalex86.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mostly_read data section
Message-Id: <20050628130119.5eb366d6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0506281247360.1933@graphe.net>
References: <Pine.LNX.4.62.0506281152060.1116@graphe.net>
	<Pine.LNX.4.62.0506281247360.1933@graphe.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
> -static unsigned long hpet_usec_quotient;	/* convert hpet clks to usec */
>  +static unsigned long __read_mostly hpet_usec_quotient;	/* convert hpet clks to usec */

__read_mostly

>   static unsigned long tsc_hpet_quotient;		/* convert tsc to hpet clks */
>   static unsigned long hpet_last; 	/* hpet counter value at last tick*/
>   static unsigned long last_tsc_low;	/* lsb 32 bits of Time Stamp Counter */
>  @@ -193,7 +193,7 @@ static int hpet_resume(void)
>   /************************************************************/
>   
>   /* tsc timer_opts struct */
>  -static struct timer_opts timer_hpet = {
>  +static struct timer_opts timer_hpet __mostly_read = {

__mostly_read.


I suggest you use __read_mostly throughout.
