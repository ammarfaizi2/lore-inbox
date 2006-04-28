Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbWD1Ph3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWD1Ph3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbWD1Ph3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:37:29 -0400
Received: from canuck.infradead.org ([205.233.218.70]:60371 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1030430AbWD1Ph3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:37:29 -0400
Subject: Re: Simple header cleanups
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0604281729250.9011@yvahk01.tjqt.qr>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
	 <1146105458.2885.37.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org>
	 <1146107871.2885.60.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
	 <20060427213754.GU3570@stusta.de>
	 <Pine.LNX.4.64.0604271439100.3701@g5.osdl.org>
	 <20060427231200.GW3570@stusta.de>
	 <Pine.LNX.4.64.0604271656390.3701@g5.osdl.org>
	 <Pine.LNX.4.61.0604281729250.9011@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 16:37:03 +0100
Message-Id: <1146238623.11909.524.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 17:32 +0200, Jan Engelhardt wrote:
> Sounds like they want it BSD-style. Do they realize that?
> New release, new headers, making it necessary to recompile every app, 
> because a struct could have changed. That'd seriously impact 
> compatibility.

Utter crap.

We don't _change_ any of the structs which would be exposed in such
files (i.e. the structs which should be outside the #ifdef __KERNEL__ at
the moment, because that would mean we break userspace binary
compatibility from kernel to kernel.

We absolutely do _NOT_ want to go there. We're talking about cleaning up
the existing mess, not starting a crack habit.

-- 
dwmw2

