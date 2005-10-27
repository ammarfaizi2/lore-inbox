Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVJ0PNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVJ0PNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbVJ0PNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:13:21 -0400
Received: from mail.suse.de ([195.135.220.2]:37067 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751043AbVJ0PNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:13:21 -0400
From: Andreas Schwab <schwab@suse.de>
To: Neal Becker <ndbecker2@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can/should inotify support fcntl?
References: <djqmvc$64g$1@sea.gmane.org>
X-Yow: NOW, I'm supposed to SCRAMBLE two, and HOLD th' MAYO!!
Date: Thu, 27 Oct 2005 17:13:19 +0200
In-Reply-To: <djqmvc$64g$1@sea.gmane.org> (Neal Becker's message of "Thu, 27
	Oct 2005 10:07:41 -0400")
Message-ID: <jepsprxab4.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neal Becker <ndbecker2@gmail.com> writes:

> I'm trying to wrap inotify functionality for python.  I ran into a problem. 
> In order to use python's select on the fd, I need to use python's
> os.fdopen.  It seems os.fdopen calls:
>
> fcntl(4, F_GETFL)                       = -1 EBADF (Bad file descriptor)
>
> Looks like inotify doesn't support calling fcntl.  Should it?

F_GETFL is implemented in the VFS, and it can only fail if the fd does not
denote a valid file handle.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
