Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUELSQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUELSQg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUELSQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:16:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27587 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265151AbUELSQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:16:25 -0400
Date: Wed, 12 May 2004 11:15:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: Why pass pt_regs throughout the input system?
Message-Id: <20040512111529.59d366f5.davem@redhat.com>
In-Reply-To: <20040512084056.GB301@ucw.cz>
References: <200405112304.50413.dtor_core@ameritech.net>
	<20040512084056.GB301@ucw.cz>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004 10:40:56 +0200
Vojtech Pavlik <vojtech@suse.cz> wrote:

> Ask David S. Miller for details - I think the problem was with
> simultaneous invocation of multiple pt_regs printouts.

That's correct, if i'm using multiple keyboards (say one i8042 based
and one USB based) in order to get fancy debugging dumps, any scheme
that saves away info at interrupt time simply will be inaccurate and
not work.
