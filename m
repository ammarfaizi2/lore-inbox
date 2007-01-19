Return-Path: <linux-kernel-owner+w=401wt.eu-S932849AbXASCSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbXASCSQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 21:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932852AbXASCSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 21:18:16 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:47255
	"EHLO grelber.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932849AbXASCSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 21:18:15 -0500
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: Do SIG_DFL handlers have SA_RESTART?
Date: Thu, 18 Jan 2007 21:17:52 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701182117.52385.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do the default signal handlers for Linux behave as if they were installed with 
SA_RESTART, or not?  (I tried querying 'em with sigaction but the defaults 
all have sa_flags 0.)

I remember years ago hitting a bug where ctrl-z followed by fg would cause 
pipelined processes to drop data, and would like to avoid that without having 
to wrap every darn syscall and check for -EINTR.  I _think_ that I just have 
to feed SA_RESTART to the signals I register handlers for myself, but I'd 
like to confirm that.

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
