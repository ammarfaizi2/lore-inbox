Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbTIPQBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 12:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbTIPQBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 12:01:17 -0400
Received: from ool-43524450.dyn.optonline.net ([67.82.68.80]:27796 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id S261951AbTIPP6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:58:50 -0400
Date: Tue, 16 Sep 2003 11:58:45 -0400
Message-Id: <200309161558.h8GFwjRw025552@buggy.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: df hangs on nfs automounter in 2.6.0-current
In-Reply-To: <Pine.GSO.4.44.0309161732480.19310-100000@math.ut.ee>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.21 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003 17:35:49 +0300 (EEST), Meelis Roos <mroos@linux.ee> wrote:
> Current 2.6.0 (2.6.0-test5+BK as of 16.09) hangs on df when
> the am_utils automounter is in use. It displays hda* partitions and next
> by mountpoint list is amd but then df hangs, wchan is rpc_execu*

You're going to have to figure out what amd is doing at that point -- 
whether it's dead, spinning, waiting for a child process, or something 
else. Hanging on df is the expected behavior if amd is not responding to 
nfs requests.

Ion
[amd co-maintainer]

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
