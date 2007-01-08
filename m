Return-Path: <linux-kernel-owner+w=401wt.eu-S1030381AbXAHWi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbXAHWi1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbXAHWi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:38:27 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48929 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964982AbXAHWi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:38:26 -0500
In-Reply-To: <20070108134152.GA19811@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com
MIME-Version: 1.0
Subject: Re: mprotect abuse in slim
X-Mailer: Lotus Notes Release 7.0.1P Oct 16, 2006
Message-ID: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com>
From: Mimi Zohar <zohar@us.ibm.com>
Date: Mon, 8 Jan 2007 17:38:25 -0500
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V80_M3_10312006|October 31, 2006) at
 01/08/2007 17:38:25,
	Serialize complete at 01/08/2007 17:38:25
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SLIM implements dynamic process labels, so when a process
is demoted, we must be able to revoke write access to some
resources to which it has previously valid handles.
For example, if a shell reads an untrusted file, the
shell is demoted, and write access to more trusted files
revoked. Based on previous comments on lkml, we understand
that this is not really possible in general, so SLIM only
attempts to revoke access in certain simple cases.

Starting with the fdtable, would it help if we move the 
fdtable tweaking out of slim itself and into helpers?  Or
can you recommend another way to implement this functionality.

Mimi Zohar


