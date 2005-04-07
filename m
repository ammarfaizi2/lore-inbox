Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVDGAIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVDGAIC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 20:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVDGAIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 20:08:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15772 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262357AbVDGAH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 20:07:57 -0400
Date: Wed, 6 Apr 2005 17:07:46 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "Gabor Z. Papp" <gzp@papp.hu>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: 2.4.30: pwc pwc_isoc_handler() called with status -84
Message-ID: <20050406170746.048e5b58@lembas.zaitcev.lan>
In-Reply-To: <20050405135552.GB7409@logos.cnet>
References: <x6ekdqgyfm@gzp>
	<20050405135552.GB7409@logos.cnet>
X-Mailer: Sylpheed-Claws 1.0.1cvs20.1 (GTK+ 2.6.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005 10:55:52 -0300 Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> CCing Pete.
> 
> On Mon, Apr 04, 2005 at 08:59:57PM +0200, Gabor Z. Papp wrote:

> > It was working fine with 2.4.29 and earlier kernels, often with
> > 100-150 days uptime.
> > 
> > As I upgraded to 2.4.30-rc kernels, started getting such error in my
> > kernel log:
> > 
> > pwc Too many ISOC errors, bailing out.
> > pwc pwc_isoc_handler() called with status -84 [CRC/Timeout (could be anything)].

There is no other way but to start splitting patches and diff-ing.
We can narrow this down a little by looking at what _might_ be involved.
Is this device driven by EHCI? A snapshot of /proc/bus/usb/devices
would be useful (BTW, Gabor, please do it on both 2.4.28 and 2.4.30-rc).

Thanks,
-- Pete
