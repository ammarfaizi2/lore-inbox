Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275898AbTHOLHj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 07:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275899AbTHOLHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 07:07:39 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:6839 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S275898AbTHOLHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 07:07:37 -0400
Date: Fri, 15 Aug 2003 12:07:00 +0100
From: Dave Jones <davej@redhat.com>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via KT400 agpgart issues
Message-ID: <20030815110700.GE22433@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Mark Watts <m.watts@eris.qinetiq.com>, linux-kernel@vger.kernel.org
References: <200308141025.12747.m.watts@eris.qinetiq.com> <20030814184838.GB10901@redhat.com> <200308150859.03617.m.watts@eris.qinetiq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308150859.03617.m.watts@eris.qinetiq.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 08:59:03AM +0100, Mark Watts wrote:

 > I thought the KT400 chipset (at least) had been backported to 2.4.21 ?

Only for AGP2.x mode.

 > I'm not experiancing any technical problems. The nvidia /proc interfaces are 
 > reporting that I'm running at agp 8x

if its using its own agpgart routines, maybe. If it isn't, it's broken,
or lying.

 > , and I have full hardware acceleration 
 > enough to play games like Unreal Tournament 2003 quite fast (~50fps), its 
 > just that agpgart cant find my aperature size...

which happens when agpgart tries to read the AGP2.x size, when the
chipset is in 3.x mode.

 > I just tried my vendors (mandrake) 2.4.22 kernel and I get exactly the same 
 > output.

No vendor that I know of has backported the AGP3 support it its
entirity. The closest to a backport so far is the trainwreck that
is the ATI FireGL drivers.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
