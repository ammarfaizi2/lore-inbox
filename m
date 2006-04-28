Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWD1SFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWD1SFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 14:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWD1SFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 14:05:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:4266 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751780AbWD1SFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 14:05:43 -0400
Date: Fri, 28 Apr 2006 14:05:33 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
Message-ID: <20060428180533.GC7061@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060427014141.06b88072.akpm@osdl.org> <pan.2006.04.27.15.47.20.688183@free.fr> <20060427180227.GA1404@in.ibm.com> <44523DB5.1050206@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44523DB5.1050206@free.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 06:07:17PM +0200, matthieu castet wrote:
> Vivek Goyal wrote:
> >On Thu, Apr 27, 2006 at 05:47:25PM +0200, Matthieu CASTET wrote:
> >
> >
> >I think it would break on ppc64 as u64 is unsigned long. It should be
> >explicitly typecasted to unsigned long long. Same is true for all the
> >instances.
> On 64 bits platform, unsigned long isn't the same as unsigned long long ?
> 
> Do you mean there will be a warning ?

Yes.

> But pnp_printf is a variadic fonction (with no attribute format printf), 
> so gcc can't check the arguments type.
> 

You are right. I did not notice that for pnp_printf(), attribute format
printf is not specified. So gcc won't do the type checking on format string
arguments.

( __attribute__ ((format (printf, 2, 3)));

Thanks
Vivek
