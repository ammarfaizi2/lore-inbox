Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbTEAAoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbTEAAoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:44:12 -0400
Received: from mx12.arcor-online.net ([151.189.8.88]:6287 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id S262642AbTEAAoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:44:11 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Thu, 1 May 2003 03:02:14 +0200
User-Agent: KMail/1.5.1
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0304300709300.7157-100000@home.transmeta.com> <200304302115.33424.dphillips@sistina.com> <20030430205921.GB7356@alpha.home.local>
In-Reply-To: <20030430205921.GB7356@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305010302.14927.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 April 2003 22:59, Willy Tarreau wrote:
> On Wed, Apr 30, 2003 at 09:15:33PM +0200, Daniel Phillips wrote:
> > In the dawn of time, before God gave us Cache, my version would have been
> > the fastest, because it executes the fewest instructions.  In the misty
> > future, as cache continues to scale and processors sprout more parallel
> > execution units, it will be clearly better once again.
>
> Daniel,
>
> I must acknowledge that your simple code was not easy to beat ! You can try
> this one on your PIII, I could only test it on an athlon mobile and a P4.
> With gcc 2.95.3, it gives me a boost of about 25%, because it seems as gcc
> cannot optimize shifts efficiently. On 3.2.3, however, it's between 0 and
> 5% depending on optimization/CPU.

Was something ifdef'd incorrectly?  Otherwise, there is something the PIII 
hates about that code.  I got 107 seconds on the PIII, vs 53 seconds for my 
posted code at O3, and virtually no difference at O2.  (gcc 3.2.3)

Regards,

Daniel

