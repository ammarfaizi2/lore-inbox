Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161463AbWKERfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161463AbWKERfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161413AbWKERfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:35:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15548 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161463AbWKERfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:35:18 -0500
Subject: Re: [rfc patch] i386: don't save eflags on task switch
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611050920220.25218@g5.osdl.org>
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com>
	 <200611050641.14724.ak@suse.de> <454D9A75.7010204@vmware.com>
	 <200611051801.18277.ak@suse.de>
	 <Pine.LNX.4.64.0611050920220.25218@g5.osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 05 Nov 2006 18:34:39 +0100
Message-Id: <1162748079.3160.102.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Andi, one single bug is usually worth _months_ of peoples time and effort. 
> How many CPU cycles is that? 

actually lockdep is pretty good at finding this type of bug IMMEDIATELY
even without the actual race triggering ;)

(but I otherwise agree that unless there is a
"sti-conditional-on-zero-flag" or something.... it's probably a void
optimization in the general uninlined case)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

