Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWADT7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWADT7I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbWADT6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:58:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7602 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965283AbWADT5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:36 -0500
Date: Wed, 4 Jan 2006 14:57:26 -0500
From: Dave Jones <davej@redhat.com>
To: Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060104195726.GB14782@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104190554.GG10592@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 02:05:54PM -0500, Dave Jones wrote:
 > On Wed, Jan 04, 2006 at 12:00:00PM +1100, Con Kolivas wrote:
 >  >  +2.6.15-dynticks-060101.patch
 >  >  +dynticks-disable_smp_config.patch
 >  > Latest version of the dynticks patch. This is proving stable and effective on 
 >  > virtually all uniprocessor machines and will benefit systems that desire 
 >  > power savings. SMP kernels (even on UP machines) still misbehave so this 
 >  > config option is not available by default for this stable kernel.
 > 
 > I've been curious for some time if this would actually show any measurable
 > power savings. So I hooked up my laptop to a gizmo[1] that shows how much
 > power is being sucked.
 > 
 > both before, and after, it shows my laptop when idle is pulling 21W.
 > So either the savings here are <1W (My device can't measure more accurately
 > than a single watt), or this isn't actually buying us anything at all, or
 > something needs tuning.

Ah interesting. It needs to be totally idle for a period of time before
anything starts to happen at all. After about a minute of doing nothing,
it started to fluctuate once a second 20,21,19,20,19,20,18,21,19,20,22 etc..

Goes no lower than 18W, and only occasionally peaks above the old idle
power usage. Not bad at all.

Causing any activity at all puts it back to the 'have to wait a while
for things to start happening' state again.

		Dave

