Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264243AbTEOUKL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 16:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264244AbTEOUKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 16:10:11 -0400
Received: from 136.231.118.64.mia-ftl.netrox.net ([64.118.231.136]:11716 "EHLO
	smtp.netrox.net") by vger.kernel.org with ESMTP id S264243AbTEOUJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 16:09:23 -0400
Subject: Re: 2.6 must-fix list, v2
From: Robert Love <rml@tech9.net>
To: shaheed <srhaque@iee.org>
Cc: Felipe Alfaro Solana <yo@felipe-alfaro.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200305152107.17419.srhaque@iee.org>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
	 <1052990397.3ec35bbd5e008@netmail.pipex.net> <1053012743.899.5.camel@icbm>
	 <200305152107.17419.srhaque@iee.org>
Content-Type: text/plain
Message-Id: <1053030280.899.27.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (1.3.3-2) (Preview Release)
Date: 15 May 2003 16:24:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 16:07, shaheed wrote:

> I'm sorry to appear foolish, but as explained above, I genuinely don't 
> understand why this does not belong in the kernel. I would be grateful for 
> elaboration. If I really am being thick, then just ignore me and I'll just 
> solve this for myself using route 4.

Oh, one other problem with doing it in the kernel via INIT_TASK:

You end up affining any kernel threads, which you absolutely do not want
to do _implicitly_. Maybe explicitly, but certainly not implicitly as a
blind consequence.

Doing it via init is really the way to go.

Regards,

	Robert Love

