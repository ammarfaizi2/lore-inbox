Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbTLKTOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265217AbTLKTOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:14:39 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:24336
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S265215AbTLKTOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:14:37 -0500
Subject: Re: mlock() "bogus check" (locked > num_physpages/2) _does_ hurt!
From: Rob Love <rml@tech9.net>
To: Lutz Vieweg <lkv@isg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3FD8BE9D.9000701@isg.de>
References: <3FD8BE9D.9000701@isg.de>
Content-Type: text/plain
Message-Id: <1071170077.13785.107.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 11 Dec 2003 14:14:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-11 at 13:59, Lutz Vieweg wrote:

> Is there any good reason to keep this check in the 2.4 kernel sources?

Not really.

> It's good to know the check is not present in the 2.6 sources, but I would
> like to get rid of it in 2.4, too...

It was removed from 2.6 for the reasons you cite.  2.4 could follow
suit.

It does lead to problems, though, where you can memlock too much memory
and lock the machine up.  But we could file that under "don't do that".

	Rob Love


