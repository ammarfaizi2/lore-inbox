Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVBNQyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVBNQyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 11:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVBNQyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 11:54:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:174 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261484AbVBNQyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 11:54:16 -0500
Date: Mon, 14 Feb 2005 11:54:07 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] 4/5: LSM hooks rework
In-Reply-To: <20050213211210.GL27893@tpkurt.garloff.de>
Message-ID: <Pine.LNX.4.61.0502141152560.14001@chimarrao.boston.redhat.com>
References: <20050213210515.GH27893@tpkurt.garloff.de>
 <20050213211034.GI27893@tpkurt.garloff.de> <20050213211109.GJ27893@tpkurt.garloff.de>
 <20050213211139.GK27893@tpkurt.garloff.de> <20050213211210.GL27893@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2005, Kurt Garloff wrote:

> The case that security_ops points to the default capability_
> security_ops is the fast path and arguably the more likely one
> on most systems.

Quite a few distributions ship with other security modules
enabled by default, so I'm not sure we should add a "likely"
here - let the CPU's branch prediction sort things out.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
