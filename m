Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWGETZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWGETZE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWGETZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:25:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964995AbWGETZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:25:02 -0400
Date: Wed, 5 Jul 2006 15:24:56 -0400
From: Dave Jones <davej@redhat.com>
To: Ben Pfaff <blp@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit VIA and SIS AGP choices to x86
Message-ID: <20060705192456.GG1877@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ben Pfaff <blp@cs.stanford.edu>, linux-kernel@vger.kernel.org
References: <20060705175725.GL1605@parisc-linux.org> <20060705111057.a03fbcec.akpm@osdl.org> <8764ib29m1.fsf@benpfaff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8764ib29m1.fsf@benpfaff.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 11:24:22AM -0700, Ben Pfaff wrote:
 > > Sure, the driver will not be used on that architecture.  But there is some
 > > benefit in being able to cross-compile that driver on other architectures
 > > anyway.  Sometimes it will pick up missed #includes, sometimes printk
 > > mismatches, various other assumptions which might be OK for x86 right now
 > > but which might cause problems in the future.
 > 
 > Should we have a NONNATIVE config option analogous to
 > EXPERIMENTAL, so that it could be expressed as
 >         depends on AGP && (X86 || NONNATIVE)
 > Seems to express the actual intentions.

Gah, that would be awful. It'd end up riddled through kconfigs everywhere.
It's also not really buying anything more than
(X86 || !X86) , at which point, they cancel each other out ;)

		Dave

-- 
http://www.codemonkey.org.uk
