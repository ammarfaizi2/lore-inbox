Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVC1TMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVC1TMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVC1TMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:12:30 -0500
Received: from graphe.net ([209.204.138.32]:21775 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261994AbVC1TM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:12:26 -0500
Date: Mon, 28 Mar 2005 11:12:22 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Oleg Nesterov'" <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: RE: [PATCH 0/5] timers: description
In-Reply-To: <200503261952.j2QJq1g27569@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0503281111220.26639@server.graphe.net>
References: <200503261952.j2QJq1g27569@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, Chen, Kenneth W wrote:

> Oleg Nesterov wrote on March 19, 2005 17:28:48
> > These patches are updated version of 'del_timer_sync: proof of
> > concept' 2 patches.
>
> I changed schedule_timeout() to call the new del_timer_sync instead of
> currently del_singleshot_timer_sync in attempt to stress these set of
> patches a bit more and I just observed a kernel hang.
>
> The symptom starts with lost network connectivity.  It looks like the
> entire ethernet connections were gone, followed by blank screen on the
> console.  I'm not sure whether it is a hard or soft hang, but system
> is inaccessible (blank screen and no network connection). I'm forced
> to do a reboot when that happens.

Same problems here with occasional hangs w/o changes to schedule_timeout.

