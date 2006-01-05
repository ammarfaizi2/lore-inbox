Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWAEJZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWAEJZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 04:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbWAEJZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 04:25:25 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:57578 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1750884AbWAEJZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 04:25:24 -0500
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] sonypi: Enable ACPI events for Sony laptop hotkeys
In-Reply-To: <0ISL001SM95JWW@a34-mta01.direcway.com>
References: <0ISL001SM95JWW@a34-mta01.direcway.com>
Date: Thu, 5 Jan 2006 09:25:24 +0000
Message-Id: <E1EuRN6-0006Hu-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@ubuntu.com> wrote:
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>

This one's a bit of a hack - it pushes Sony hotkey magic stuff through
the ACPI layer for the sake of consistency, despite the fact that
there's not actually any ACPI involved. 

The "right" way is probably actually to push ACPI hotkey events through
the input layer (like the Sony code does without this patch), but that's
currently a bit more awkward to handle in userspace. Since the right
answer here is clearly "Fix userspace", we probably don't want to be
merging this.

(Disclaimer: I wrote it originally because it was easier than fixing
userspace...)
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
