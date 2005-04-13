Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVDMLLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVDMLLQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVDMLLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:11:16 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:42987 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261308AbVDMLLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:11:12 -0400
To: Tomko <tomko@haha.com>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: Why system call need to copy the date from the userspace before
 using it
References: <425C9E55.6010607@haha.com> <20050413102916.GS4965@lug-owl.de>
	<425CF7DB.4000407@haha.com>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 13 Apr 2005 12:10:46 +0100
In-Reply-To: <425CF7DB.4000407@haha.com> (tomko@haha.com's message of "Wed,
 13 Apr 2005 18:43:39 +0800")
Message-ID: <tnxd5szvsnd.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomko <tomko@haha.com> wrote:
> Inside the system call , the kernel often copy the data by calling
> copy_from_user() rather than just using strcpy(), is it because the
> memory mapping in kenel space is different from user space?

No, it is because this function checks whether the access to the user
space address is OK. There are situations when it can also sleep (page
not present).

-- 
Catalin

