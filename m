Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbVKWXFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbVKWXFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030481AbVKWXFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:05:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:10468 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030478AbVKWXFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:05:12 -0500
Subject: Re: [git pull 09/14] Uinput: add UI_SET_SWBIT ioctl
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051120064420.389911000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
	 <20051120064420.389911000.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 10:01:27 +1100
Message-Id: <1132786887.26560.341.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh,and ... ARGH !

So you pass that nice structure 

struct input_event {
	struct timeval time;
	__u16 type;
	__u16 code;
	__s32 value;
};

to userland via read() ... cool, a structure that is not compatible
between 32 and 64 bits passed around via a read call. that will be fun
to fix.

Ben.


