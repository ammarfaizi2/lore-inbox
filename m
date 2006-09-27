Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031238AbWI0XUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031238AbWI0XUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031245AbWI0XUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:20:22 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:54470 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1031238AbWI0XUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:20:21 -0400
Subject: Re: [RFC] exponential update_wall_time
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060927150501.3d40e11e.akpm@osdl.org>
References: <1159385734.29040.9.camel@localhost>
	 <20060927150501.3d40e11e.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 16:20:21 -0700
Message-Id: <1159399221.7297.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 15:05 -0700, Andrew Morton wrote:
> On Wed, 27 Sep 2006 12:35:33 -0700
> john stultz <johnstul@us.ibm.com> wrote:
> 
> > +	while (offset > clock->cycle_interval << (shift + 1))
> > +		shift++;
> 
> hurts my brain.

Yea. Its not the most obvious patch, but the complexity is pretty
isolated.

> I have a vague feeling that this can be done with
> something like ffz(~(offset/clock->cycle_interval))+epsilon, but that hurts
> my brain too.

Agreed. I don't want to obfuscate this code much more. In my opinion,
the loop is tightly bounded and not expensive enough to try to optimize.

thanks
-john


