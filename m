Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWJROcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWJROcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbWJROcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:32:24 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:16369 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161036AbWJROcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:32:23 -0400
Subject: Re: [PATCH -rt] powerpc update
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
       mgreer@mvista.com, sshtylyov@ru.mvista.com
In-Reply-To: <20061018072858.GA29576@elte.hu>
References: <20061003155358.756788000@dwalker1.mvista.com>
	 <20061018072858.GA29576@elte.hu>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 07:32:21 -0700
Message-Id: <1161181941.23082.32.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 09:28 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > Pay close attention to the fasteoi interrupt threading. I added usage 
> > of mask/unmask instead of using level handling, which worked well on 
> > PPC.
> 
> this is wrong - it should be doing mask+ack.

The main reason I did it this way is cause the current threaded eoi
expected the line to be masked. So if you happen to have a eoi that's
threaded you get a warning then the interrupt hangs. 

> also note that you changed:

> > -		goto out_unlock;
> 
> to:
> 
> > +		goto out;
> 
> and you even tried to hide your tracks:

hiding something? I made note of these changes specifically so you would
review them.

Daniel

