Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUGYVft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUGYVft (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 17:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbUGYVft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 17:35:49 -0400
Received: from centaur.culm.net ([83.16.203.166]:47622 "EHLO centaur.culm.net")
	by vger.kernel.org with ESMTP id S264503AbUGYVfr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 17:35:47 -0400
From: Witold Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Disabling compiled-in modules at kernel boot cmdline?
Date: Sun, 25 Jul 2004 23:35:37 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407252335.37487.adasi@kernel.pl>
X-Spam-Score: -4.7 (----)
X-MIME-Warning: Serious MIME defect detected ()
X-Scan-Signature: fd30f7fe92f0baa0e673755cf3407eaf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Case: I'm using PowerBook with stock PLD Linux PPC kernel, it has i8042 and 
8250 modules built-in. But, those have no use on this machine (as those are 
for IBM RS/6000), and actually are really messing stuff (e.g. i8042 gives a 
lot of debug info to kernel log (that it cannot find a device blah blah), 
with 8250 I cannot use pmac_zilog driver (there is a conflict somewhere)).

Quick look at the code told me that currently there is no possibility to 
disable compiled-in kernel modules at boottime. Would it be hard to do? For 
example I give module_i8042=off (or sth. ) and initcall for i8042 is not 
called. That would be probably enough.

Yes, I know that the solution is compiling kernel myself, but doing it every 
week (for testing purposes) for about 2-3 hour could be annoying...

-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
