Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbUKEQ4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbUKEQ4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbUKEQ4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:56:50 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:44469 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262700AbUKEQ4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:56:49 -0500
Subject: Re: [RFC] [PATCH] [0/6] LSM Stacking
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200411050723.iA57NGUv023856@turing-police.cc.vt.edu>
References: <1099609471.2096.10.camel@serge.austin.ibm.com>
	 <200411050723.iA57NGUv023856@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1099673502.6373.190.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 05 Nov 2004 11:51:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-05 at 02:23, Valdis.Kletnieks@vt.edu wrote:
> One issue:  I'm seeing this from /usr/sbin/sendmail:
> 
> % /usr/sbin/sendmail
> drop_privileges: setuid(0) succeeded (when it should not)
> 
> I've not tracked down what's causing this indigestion yet (I suspect some
> bad interaction with capabilities - that's what caused that message to be
> added to Sendmail in the first place).

stacker module is granting capability if any security module allows it
under the view that the capable() hook is authoritative.  But that is a
mistake; if you look at the existing stacking support in SELinux for
capabilities, we require both modules to approve the capability.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

