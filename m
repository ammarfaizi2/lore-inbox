Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275367AbTHQBKn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 21:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275464AbTHQBKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 21:10:43 -0400
Received: from are.twiddle.net ([64.81.246.98]:31633 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S275367AbTHQBKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 21:10:41 -0400
Date: Sat, 16 Aug 2003 18:10:35 -0700
From: Richard Henderson <rth@twiddle.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Samuel Thibault <samuel.thibault@fnac.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] single return paradigm
Message-ID: <20030817011035.GA22022@twiddle.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Samuel Thibault <samuel.thibault@fnac.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030726221655.GB1148@bouh.unh.edu> <1059302602.12754.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059302602.12754.3.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 11:43:22AM +0100, Alan Cox wrote:
> When you tell gcc to build with profiling it provides the right hooks
> for you to provide alternate code to the libc profile code

Starting with gcc 3.3, there is __attribute__((cleanup(foo))),
which, when applied to a local variable, is effectively 
destructors for C.  Foo will be invoked with a pointer to the
variable just before the variable goes out of scope.


r~
