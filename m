Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934038AbWKTJs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934038AbWKTJs6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 04:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934039AbWKTJs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 04:48:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18571 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934038AbWKTJs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 04:48:57 -0500
Message-ID: <456179F6.1060501@redhat.com>
Date: Mon, 20 Nov 2006 09:48:38 +0000
From: Patrick Caulfield <pcaulfie@redhat.com>
Organization: Red Hat
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
       David Teigland <teigland@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.19-rc5-mm2] fs/dlm: fix recursive dependency in Kconfig
References: <tkrat.c2d67cf7278af0e7@s5r6.in-berlin.de>
In-Reply-To: <tkrat.c2d67cf7278af0e7@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> make xconfig says
> "Warning! Found recursive dependency: INET IPV6 DLM (null) DLM_TCP INET"
> 
> Seems to be another example of how badly the "select" keyword is handled
> by the .config make targets. Replace all occurences of "select" in dlm's
> Kconfig by "depends on" and some additional help texts.
> 

The problem I found when using DEPENDS rather than SELECT in that position is that if you don't already have LINET or SCTP selected
then neither of the transports appear and you can effectively select the DLM without any transports. and that won't compile.

I prefer the already posted solutions to this.


patrick
