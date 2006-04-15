Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWDORmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWDORmo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 13:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWDORmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 13:42:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37531 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030297AbWDORmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 13:42:43 -0400
Date: Sat, 15 Apr 2006 10:41:59 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
In-Reply-To: <20060415090639.dde469e8.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604151040450.25886@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
 <20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
 <20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604140945320.18453@schroedinger.engr.sgi.com>
 <20060415090639.dde469e8.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that there is an issue with your approach. If a migration entry is 
copied during fork then SWP_MIGRATION_WRITE must become SWP_MIGRATION_READ 
for some cases. Would you look into fixing this?

