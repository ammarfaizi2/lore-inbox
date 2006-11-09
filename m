Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753585AbWKIHfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbWKIHfK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 02:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbWKIHfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 02:35:10 -0500
Received: from za-gw.sanpeople.com ([196.211.225.226]:22285 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1753585AbWKIHfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 02:35:08 -0500
Subject: Re: [-mm patch 1/4] GPIO framework for AVR32
From: Andrew Victor <andrew@sanpeople.com>
To: David Brownell <david-b@pacbell.net>
Cc: hskinnemoen@atmel.com, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20061108180059.845DE1DC95A@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
	 <20061107122715.3022da2f@cad-250-152.norway.atmel.com>
	 <20061107131014.535ab280.akpm@osdl.org>
	 <20061107223741.62FA21DC801@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	 <20061108124823.308ae3b4@cad-250-152.norway.atmel.com>
	 <20061108180059.845DE1DC95A@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1163057161.14573.180.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Nov 2006 09:26:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi David,

> > > 	* int gpio_set_direction(unsigned gpio, int is_in /* or
> > >           		is_out? */)
> > >         ... returning 0 or negative errno (for invalid gpio)
> >
> > I think set_output_enable makes more sense, but maybe it's just me.
> 
> It's just you.  :)
> 
> A "set enable" idiom is linguistically redundant too; "set" suffices,
> or "enable".  Both imply a need for an opposite "clear" or "disable.
> "Direction" is a more obvious notion; the parameter should likely be
> a symbol like GPIO_IN or GPIO_OUT.

We originally had at91_set_gpio_direction() in the AT91 GPIO layer, and
that seemed to cause confusion  (eg, do I pass a 1 or 0 to enable output
mode?)

So I'd personally prefer to keep gpio_set_input() and
gpio_set_output().  (alternative is "enable" instead of "set").  I think
it's more readable.


Regards,
  Andrew Victor


