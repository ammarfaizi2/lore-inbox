Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286200AbRLJIkq>; Mon, 10 Dec 2001 03:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286203AbRLJIkg>; Mon, 10 Dec 2001 03:40:36 -0500
Received: from zero.tech9.net ([209.61.188.187]:44806 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S286200AbRLJIka>;
	Mon, 10 Dec 2001 03:40:30 -0500
Subject: Re: [PATCH] proc-based cpu affinity user interface
From: Robert Love <rml@tech9.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200112100833.fBA8X6m209019@saturn.cs.uml.edu>
In-Reply-To: <200112100833.fBA8X6m209019@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 10 Dec 2001 03:40:32 -0500
Message-Id: <1007973633.874.38.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 03:33, Albert D. Cahalan wrote:

> It looks like you are limiting the number of CPUs to sizeof(long).
> Must you? Using "%lx" would be better in any case. Considering that
> you may outgrow the format, maybe this info doesn't belong in the
> /proc/*/stat files at all. For "ps" usage, a simple flag to indicate
> if the process is locked to a CPU would be OK. There are 3 cases
> of interest:

We already limit it... we use cpus_allowed and cpus_runnable which are
unsigned long.

	Robert Love

