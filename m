Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422766AbWJSG4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422766AbWJSG4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161340AbWJSG4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:56:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161325AbWJSG4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:56:07 -0400
Date: Wed, 18 Oct 2006 23:56:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: CIJOML <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 185] Sometimes kernel freezes sometime lists OOPS -
 hostap_cs
Message-Id: <20061018235604.47886be9.akpm@osdl.org>
In-Reply-To: <200610171747.34177.cijoml@volny.cz>
References: <200610171747.34177.cijoml@volny.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 17:47:34 +0200
CIJOML <cijoml@volny.cz> wrote:

> can anybody take a look at this bug?
> 
> http://hostap.epitest.fi/bugz/show_bug.cgi?id=185
> 
> pccard: PCMCIA card inserted into slot 1
> pcmcia: registering new device pcmcia1.0
> ieee80211_crypt: registered algorithm 'NULL'
> hostap_cs: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
> hostap_cs: Registered netdevice wifi0
> IRQ handler type mismatch for IRQ 3

Looks like whatever driver is driving irda0 is refusing to share interrupts.

Which driver is that?
