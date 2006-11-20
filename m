Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWKTXis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWKTXis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966880AbWKTXis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:38:48 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:52571 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966869AbWKTXir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:38:47 -0500
Date: Mon, 20 Nov 2006 15:35:28 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Patrick Caulfield <pcaulfie@redhat.com>, cluster-devel@redhat.com,
       linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.19-rc5-mm2] fs/dlm: fix recursive dependency in
 Kconfig
Message-Id: <20061120153528.5ace6089.randy.dunlap@oracle.com>
In-Reply-To: <20061120174509.GW31879@stusta.de>
References: <tkrat.c2d67cf7278af0e7@s5r6.in-berlin.de>
	<456179F6.1060501@redhat.com>
	<45619547.5070301@s5r6.in-berlin.de>
	<20061120174509.GW31879@stusta.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 18:45:09 +0100 Adrian Bunk wrote:

> On Mon, Nov 20, 2006 at 12:45:11PM +0100, Stefan Richter wrote:
> >...
> > Anyway. Whatever you chose to do (or already have chosen to do) in
> > fs/dlm/Kconfig, keep in mind that the "select" keyword is presently only
> > poorly supported by the various .config generators and that it forces UI
> > considerations into the Kconfig files which should better not be
> > overloaded with UI issues. Or in other words: It is rather easy to write
> > correct and well-supported Kconfig files if you stick with "depend on",
> > but you get into trouble fast with generous usage of "select".
> 
> For variables like NET or INET it doesn't matter in practice whether you 
> use "select" or "depends on". But for other variables it makes it really 
> hard for users to enable an option if you use "depends on".

Doing a "select" NET or INET enables a ton of code, which IMO
should be done explicitly, not covertly by a select.

---
~Randy
