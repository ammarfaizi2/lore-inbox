Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265886AbUFOT3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUFOT3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbUFOT3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:29:38 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:2301 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265886AbUFOT3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:29:36 -0400
To: Dean Nelson <dcn@sgi.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: calling kthread_create() from interrupt thread
References: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com>
	<1087321777.2710.43.camel@laptop.fenrus.com>
	<20040615191440.GA17669@sgi.com>
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: 15 Jun 2004 12:27:45 -0700
In-Reply-To: <20040615191440.GA17669@sgi.com>
Message-ID: <52y8mowrim.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 Jun 2004 19:27:45.0827 (UTC) FILETIME=[D6013F30:01C4530E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Dean> Can an interrupt handler setup a work_struct structure, call
    Dean> schedule_work() and then simply return, not waiting around
    Dean> for the work queue event to complete?

Yes (as long as the work_struct structure is not freed at the end of
the interrupt handler or something like that).

 - Roland
