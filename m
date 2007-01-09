Return-Path: <linux-kernel-owner+w=401wt.eu-S932270AbXAIVpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbXAIVpw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbXAIVpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:45:52 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:44355 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932270AbXAIVpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:45:52 -0500
In-Reply-To: <200701091927.l09JRJXM021563@turing-police.cc.vt.edu>
To: Valdis.Kletnieks@vt.edu
Cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com
MIME-Version: 1.0
Subject: Re: mprotect abuse in slim
X-Mailer: Lotus Notes Release 7.0.1P Oct 16, 2006
Message-ID: <OF7B947612.0655A2A9-ON8525725E.00763EE0-8525725E.00785BD0@us.ibm.com>
From: Mimi Zohar <zohar@us.ibm.com>
Date: Tue, 9 Jan 2007 16:45:51 -0500
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V80_M3_10312006|October 31, 2006) at
 01/09/2007 16:45:51,
	Serialize complete at 01/09/2007 16:45:51
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote on 01/09/2007 02:27:19 PM:

>Which, unfortunately, creates incredibly brittle code when some attacker
>reads the SLIM source code and finds a way to force the non-simple case
>you ignore.
> 
>This is an area where you really need to do it *right*, or not at all.

For the non-simple case, it isn't that we 'ignore' the revocation,
but we prevent the cause for demotion to occur.  The current status is
that for those cases we can revoke, we demote the process and do the
revocation, and for those cases which we can't revoke, we prevent the 
process from being demoted.

Mimi Zohar
