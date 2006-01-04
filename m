Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWADUeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWADUeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbWADUeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:34:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21152 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964861AbWADUeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:34:03 -0500
Subject: Re: 2.6.15-ck1
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060104195726.GB14782@redhat.com>
References: <200601041200.03593.kernel@kolivas.org>
	 <20060104190554.GG10592@redhat.com>  <20060104195726.GB14782@redhat.com>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 21:33:56 +0100
Message-Id: <1136406837.2839.67.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 14:57 -0500, Dave Jones wrote:
> On Wed, Jan 04, 2006 at 02:05:54PM -0500, Dave Jones wrote:
>  > On Wed, Jan 04, 2006 at 12:00:00PM +1100, Con Kolivas wrote:
>  >  >  +2.6.15-dynticks-060101.patch
>  >  >  +dynticks-disable_smp_config.patch
>  >  > Latest version of the dynticks patch. This is proving stable and effective on 
>  >  > virtually all uniprocessor machines and will benefit systems that desire 
>  >  > power savings. SMP kernels (even on UP machines) still misbehave so this 
>  >  > config option is not available by default for this stable kernel.
>  > 
>  > I've been curious for some time if this would actually show any measurable
>  > power savings. So I hooked up my laptop to a gizmo[1] that shows how much
>  > power is being sucked.
>  > 
>  > both before, and after, it shows my laptop when idle is pulling 21W.
>  > So either the savings here are <1W (My device can't measure more accurately
>  > than a single watt), or this isn't actually buying us anything at all, or
>  > something needs tuning.
> 
> Ah interesting. It needs to be totally idle for a period of time before
> anything starts to happen at all. After about a minute of doing nothing,
> it started to fluctuate once a second 20,21,19,20,19,20,18,21,19,20,22 etc..


sounds like we need some sort of profiler or benchmarker or at least a
tool that helps finding out which timers are regularly firing, with the
aim at either grouping them or trying to reduce their disturbance in
some form.


