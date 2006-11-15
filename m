Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031003AbWKOWZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031003AbWKOWZh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031004AbWKOWZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:25:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15568 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1031003AbWKOWZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:25:36 -0500
Subject: Re: [RFCLUE3] flagging kernel interface changes
From: Arjan van de Ven <arjan@infradead.org>
To: William D Waddington <william.waddington@beezmo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <455B9133.9030704@beezmo.com>
References: <455B9133.9030704@beezmo.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 15 Nov 2006 23:25:33 +0100
Message-Id: <1163629533.31358.168.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't want to start an argument about	"stable_api_nonsense" or the
> wisdom of out-of-tree drivers.  Just curious about the - why - and
> whether it is indifference or antagonism toward drivers outside the
> fold. Or ???

Hi,

in general the best approach has been to make the driver support the NEW
interface, and then do some compat thing to fake the old one. The other
way around is going to be MUCH more painful long term.
So as general rule: always follow the latest API, and use a compat.h
hack for older kernels inside your driver, but keep the normal code
clean. It's not always easy, but keeping old API and faking it to the
new one is only going to be really really painful; things will deviate
more and more over time and at some point you'll have to jump anyway.

In addition quite a few api changes are done in a way that make this
less painful than the other way around..



however in general really there is pain to be out-of-tree; and to some degree that's an incentive to merge back :)

> - 
> if you want to mail me at work (you don't), use arjan (at) linux.intel.com
> Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

