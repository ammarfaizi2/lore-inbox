Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVBOKHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVBOKHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 05:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVBOKHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 05:07:21 -0500
Received: from mail.enyo.de ([212.9.189.167]:64411 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261667AbVBOKHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 05:07:16 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: linux-kernel@vger.kernel.org
Subject: Unspecified remote crash in the IP forwarding path (2.6 only)
Date: Tue, 15 Feb 2005 11:07:15 +0100
Message-ID: <87d5v2gmr0.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ubuntu Security Notice USN-82-1 mentions a remote crash in the IP
forwarding path. Quote from the Ubuntu security advisory (apparently,
no CVE name has been assigned so far):

| http://oss.sgi.com/archives/netdev/2005-01/msg01036.html:
| 
|   David Coulson noticed a design flaw in the netfilter/iptables module.
|   By sending specially crafted packets, a remote attacker could exploit
|   this to crash the kernel or to bypass firewall rules.
| 
|   Fixing this vulnerability required a change in the Application
|   Binary Interface (ABI) of the kernel. This means that third party
|   user installed modules might not work any more with the new kernel,
|   so this fixed kernel has a new ABI version number. You have to
|   recompile and reinstall all third party modules.

I'm not sure if the referenced patch is the correct one, it seems to
have bugs.  Does anybody know the exact impact of this vulnerability?
The thread mostly deals with a crash due to an issue in the IP
fragmentation code.  I fail to see how it's related to the netfilter
code.

(What happened to the new security process, by the way?)
