Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbULECwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbULECwq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 21:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbULECwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 21:52:46 -0500
Received: from holomorphy.com ([207.189.100.168]:39111 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261233AbULECwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 21:52:45 -0500
Date: Sat, 4 Dec 2004 18:52:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: tglx@linutronix.de
Cc: akpm@osdl.org, andrea@suse.de, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041205025236.GN2714@holomorphy.com>
References: <20041201104820.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201104820.1.patchmail@tglx>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 10:49:03AM +0100, tglx@linutronix.de wrote:
> The oom killer has currently some strange effects when triggered.
> It gets invoked multiple times and the selection of the task to kill
> does not take processes into account which fork a lot of child processes.
> The patch solves this by
> - Preventing reentrancy
> - Checking for memory threshold before selection and kill.
> - Taking child processes into account when selecting the process to kill

Hmm, this thread seems to be serious. I'll audit the policy adjustments
for issues with the mechanisms (e.g. killing kernel threads, races with
timeouts).


-- wli
