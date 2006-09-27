Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031117AbWI0WFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031117AbWI0WFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031043AbWI0WFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:05:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031117AbWI0WFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:05:21 -0400
Date: Wed, 27 Sep 2006 15:05:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] exponential update_wall_time
Message-Id: <20060927150501.3d40e11e.akpm@osdl.org>
In-Reply-To: <1159385734.29040.9.camel@localhost>
References: <1159385734.29040.9.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 12:35:33 -0700
john stultz <johnstul@us.ibm.com> wrote:

> +	while (offset > clock->cycle_interval << (shift + 1))
> +		shift++;

hurts my brain.  I have a vague feeling that this can be done with
something like ffz(~(offset/clock->cycle_interval))+epsilon, but that hurts
my brain too.

