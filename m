Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVC3GGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVC3GGk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVC3GGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:06:39 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:29149 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261583AbVC3GGh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:06:37 -0500
Date: Tue, 29 Mar 2005 22:06:36 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jay Lan <jlan@engr.sgi.com>
cc: Paul Jackson <pj@engr.sgi.com>, johnpol@2ka.mipt.ru,
       guillaume.thouvenin@bull.net, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
In-Reply-To: <4249C418.5040007@engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0503292200550.30657@twinlark.arctic.org>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
 <20050328134242.4c6f7583.pj@engr.sgi.com> <1112079856.5243.24.camel@uganda>
 <20050329004915.27cd0edf.pj@engr.sgi.com> <1112092197.5243.80.camel@uganda>
 <20050329090304.23fbb340.pj@engr.sgi.com> <4249C418.5040007@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005, Jay Lan wrote:

> The fork_connector is not designed to solve accounting data collection
> problem.
> 
> The accounting data collection must be done via a hook from do_exit().

by the time do_exit() occurs the parent may have disappeared... you do 
need to record something at fork() time so that you can account to the 
correct ancestor.

an example of where this ancestry is useful would be the summation of all 
cpu time spent by children of apache, spamd, clamd, ...

-dean
