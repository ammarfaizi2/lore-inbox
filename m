Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWCBCXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWCBCXn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 21:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWCBCXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 21:23:43 -0500
Received: from lixom.net ([66.141.50.11]:22667 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S932175AbWCBCXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 21:23:42 -0500
Date: Wed, 1 Mar 2006 20:22:44 -0600
To: Martin Bligh <mbligh@mbligh.org>
Cc: Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Fix powerpc bad_page_fault output  (Re: 2.6.16-rc5-mm1)
Message-ID: <20060302022244.GB17755@pb15.lixom.net>
References: <20060228042439.43e6ef41.akpm@osdl.org> <4404E328.7070807@mbligh.org> <20060301164531.GA17755@pb15.lixom.net> <17414.15814.146349.883153@cargo.ozlabs.ibm.com> <440646ED.2030108@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440646ED.2030108@mbligh.org>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 05:14:21PM -0800, Martin Bligh wrote:

> He's removing KERN_ALERT ... I guess it could get switched from 
> KERN_ALERT to KERN_ERR, but ...
> 
> Either way, KERN_ALERT seems way too low to me. I object to getting
> half the oops, and not the other half ;-)

Right. The new printk's were added recently, and I took the KERN_ALERT
level from the x86 code then without double-checking what die() uses. I
guess I could move the die() output over instead, or move them both to
KERN_ERR.


-Olof
