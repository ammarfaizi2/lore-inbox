Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751853AbWG0BrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbWG0BrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 21:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWG0BrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 21:47:05 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:51916 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751853AbWG0BrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 21:47:04 -0400
Date: Wed, 26 Jul 2006 21:46:58 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: liyu <liyu@ccoss.com.cn>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] usbhid: Driver for microsoft natural ergonomic keyboard 4000
Message-ID: <20060727014658.GF28284@filer.fsl.cs.sunysb.edu>
References: <44C74708.6090907@ccoss.com.cn> <20060726161232.GC28284@filer.fsl.cs.sunysb.edu> <44C80D3E.5090706@ccoss.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C80D3E.5090706@ccoss.com.cn>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 08:47:58AM +0800, liyu wrote:
> Josef Sipek wrote:
> > +#define map_key(c) \
> > +       do { \
> > +               usage->code = c; \
> > +               usage->type = EV_KEY; \
> > +               set_bit(c,input->keybit); \
> > +       } while (0)
> >
> > I'm not quite sure where usage is coming from. Some magical global variable?
> > Eeek.
> >
> > Josef "Jeff" Sipek.
> >
> >   
> These macroes like map_key() only use in nek4k_setup_usage() and
> ne4k_clear_usage(), so the variable "usage" is coming from their
> parameter.

It is still bad.

> PS: these macroes are modifed from hid-input.c

Well, hid-input.c is wrong. :) Yeah, I just looked at it, and it is horid.

Josef "Jeff" Sipek.

-- 
My public GPG key can be found at
http://www.josefsipek.net/gpg/public-0xC7958FFE.txt
