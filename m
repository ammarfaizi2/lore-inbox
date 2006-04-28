Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbWD1P7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWD1P7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030452AbWD1P7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:59:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38801 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030451AbWD1P7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:59:51 -0400
Subject: Re: Simple header cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1146238623.11909.524.camel@pmac.infradead.org>
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
	 <1146238623.11909.524.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 17:59:38 +0200
Message-Id: <1146239978.3126.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 16:37 +0100, David Woodhouse wrote:
> On Fri, 2006-04-28 at 17:32 +0200, Jan Engelhardt wrote:
> > Sounds like they want it BSD-style. Do they realize that?
> > New release, new headers, making it necessary to recompile every app, 
> > because a struct could have changed. That'd seriously impact 
> > compatibility.
> 
> Utter crap.
> 
> We don't _change_ any of the structs which would be exposed in such
> files (i.e. the structs which should be outside the #ifdef __KERNEL__ at
> the moment, because that would mean we break userspace binary
> compatibility from kernel to kernel.
> 
> We absolutely do _NOT_ want to go there. We're talking about cleaning up
> the existing mess, not starting a crack habit.
> 

btw one advantage of having the user visible structures in their own
headers is that it becomes immediately more obvious that it IS a shared
struct and any reviewer can then scream about the ABI break.,,,

