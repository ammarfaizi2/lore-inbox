Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTDFGzr (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 01:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbTDFGzr (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 01:55:47 -0500
Received: from fmr02.intel.com ([192.55.52.25]:10739 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262844AbTDFGzq (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 01:55:46 -0500
Date: Sat, 5 Apr 2003 22:56:54 -0800 (PST)
From: Scott Feldman <scott.feldman@intel.com>
X-X-Sender: scott.feldman@localhost.localdomain
To: "J.A. Magallon" <jamagallon@able.es>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] e1000 close
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E010128A52B@orsmsx402.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0304052242290.5402-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Apr 2003, J.A. Magallon wrote:

> Supposed to cure a dev_close called without dev_open.
> Is this still needed ?

I can't find the original bug report.  I thought it had to do with 
bonding, but my search came up empty.  Any help?

It bugs me that someone is calling dev->close without calling dev->open.  
On the other hand, the driver shouldn't knock everyone down just because
the caller is misbehaved, and this fix isn't in the perf path, so the
patch is good insurance.  Let's go back and figure out who was calling
dev->open out of turn.

-scott

