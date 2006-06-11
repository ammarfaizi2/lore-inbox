Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWFKQJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWFKQJK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 12:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWFKQJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 12:09:10 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:33960 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1751637AbWFKQJJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 12:09:09 -0400
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of
	physical pages backing it
From: Arjan van de Ven <arjan@infradead.org>
To: rohitseth@google.com
Cc: Andrew Morton <akpm@osdl.org>, Linux-mm@kvack.org,
       Linux-kernel@vger.kernel.org
In-Reply-To: <1149903235.31417.84.camel@galaxy.corp.google.com>
References: <1149903235.31417.84.camel@galaxy.corp.google.com>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 18:09:02 +0200
Message-Id: <1150042142.3131.82.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 18:33 -0700, Rohit Seth wrote:
> Below is a patch that adds number of physical pages that each vma is
> using in a process.  Exporting this information to user space
> using /proc/<pid>/maps interface.

is it really worth bloating the vma struct for this? there are quite a
few workloads that have a gazilion vma's, and this patch adds both
memory usage and cache pressure to those workloads...


