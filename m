Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271129AbTHMMOD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271890AbTHMMOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:14:03 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:62972 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S271129AbTHMMOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:14:01 -0400
Date: Wed, 13 Aug 2003 13:13:22 +0100
From: Dave Jones <davej@redhat.com>
To: Michel D?nzer <michel@daenzer.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] [PATCH] cpu_relax whilst in busy-wait loops.
Message-ID: <20030813121322.GE12953@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michel D?nzer <michel@daenzer.net>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
References: <E19mCuO-0003dX-00@tetrachloride> <1060770126.26452.142.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060770126.26452.142.camel@thor.holligenstrasse29.lan>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 12:22:06PM +0200, Michel D?nzer wrote:
 > > -	while ( GAMMA_READ(GAMMA_INFIFOSPACE) < 2);
 > > +	while ( GAMMA_READ(GAMMA_INFIFOSPACE) < 2)
 > > +		cpu_relax();
 > 
 > Are you actually using the gamma driver? :) Something like this might be
 > useful in other drivers as well?

No, I just stumbled across this, and remembered seeing a similar
patch some time earlier.  Indeed, there are probably other places in
DRI that need the same treatment.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
