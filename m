Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318887AbSIIVwe>; Mon, 9 Sep 2002 17:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318943AbSIIVwe>; Mon, 9 Sep 2002 17:52:34 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:23815
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318887AbSIIVwc>; Mon, 9 Sep 2002 17:52:32 -0400
Subject: Re: 2.5.3[3,4] Preemption problem
From: Robert Love <rml@tech9.net>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020909213137.28292.qmail@linuxmail.org>
References: <20020909213137.28292.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Sep 2002 17:52:11 -0400
Message-Id: <1031608332.15794.82.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 17:31, Paolo Ciarrocchi wrote:

> Halting system...
> Shutting down devices
> Power down.
> note: halt[15347] exited with preempt_count 1

Note the "note" - this is just advisory and is not harmful. :)

Somewhere in the shutdown logic a lock (probably the BKL) is not
released (and why not, we are shutting down?).  I'll see if I can find
it...

	Robert Love


