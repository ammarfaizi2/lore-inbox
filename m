Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263521AbTDMORN (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 10:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTDMORN (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 10:17:13 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:6152
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263521AbTDMORM 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 10:17:12 -0400
Subject: Re: Re: Processor sets (pset) for linux kernel 2.5/2.6?
From: Robert Love <rml@tech9.net>
To: "Shaheed R. Haque" <srhaque@iee.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1050222609.3e992011e4f54@netmail.pipex.net>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
	 <1050177383.3e986f67b7f68@netmail.pipex.net>
	 <1050177751.2291.468.camel@localhost>
	 <1050222609.3e992011e4f54@netmail.pipex.net>
Content-Type: text/plain
Organization: 
Message-Id: <1050244136.733.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 13 Apr 2003 10:28:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-13 at 04:30, Shaheed R. Haque wrote:

> Interesting idea. AFAICS, this involves either changing the code of /sbin/init 
> to set its affinity to a default cpu mask (provided by a kernel boot flag, I 
> presume), or using taskset-like functionality and then hoping that all current 
> shells etc. die before the programs I care about start.

Well, you can get away with it easier by having a program (like taskset
in schedutils) run in rc.sysinit.  Have it bind init to the appropriate
processor.

> Would it not be better to simply have the kernel use the boot flag directly as 
> the default CPU mask setting?

This is not a bad idea either, as it involves minimal code.

	Robert Love

