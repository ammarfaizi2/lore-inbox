Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbTBTSX3>; Thu, 20 Feb 2003 13:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266777AbTBTSX3>; Thu, 20 Feb 2003 13:23:29 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:23475 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266772AbTBTSX1>;
	Thu, 20 Feb 2003 13:23:27 -0500
Date: Thu, 20 Feb 2003 18:45:25 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Daniel Egger <degger@fhm.edu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Enable SSE for AMD Athlon (Thoroughbred) in 2.4.20
Message-ID: <20030220184525.GA23768@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Daniel Egger <degger@fhm.edu>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <1045266292.12105.41.camel@sonja>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045266292.12105.41.camel@sonja>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 12:44:53AM +0100, Daniel Egger wrote:
 > Hija,
 > 
 > please include the obvious oneliner attached in 2.4.21 to help
 > the poor folks having recent Athlons. :)
 > 
 > A similar change for the just released Barton would also be nice but
 > I do not have the model number handy.

It's model 10. Somehow they skipped model 9.

 > --- arch/i386/kernel/setup.c.orig	2003-02-03 13:26:38.000000000 +0100
 > +++ arch/i386/kernel/setup.c	2003-02-14 14:14:12.000000000 +0100
 > @@ -1421,7 +1421,7 @@
 >  			 * If the BIOS didn't enable it already, enable it
 >  			 * here.
 >  			 */
 > -			if (c->x86_model == 6 || c->x86_model == 7) {
 > +			if (c->x86_model == 6 || c->x86_model == 7 || c->x86_model == 8) {
 >  				if (!test_bit(X86_FEATURE_XMM,
 >  					      &c->x86_capability)) {
 >  					printk(KERN_INFO

if (c->x86_model >= 6 && c->x86_model <= 10) {

should do the right thing on all current models with SSE afaics..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
