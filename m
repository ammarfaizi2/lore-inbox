Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVD1Cw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVD1Cw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 22:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVD1Cw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 22:52:28 -0400
Received: from smtp.istop.com ([66.11.167.126]:43677 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261821AbVD1CwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 22:52:25 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Wed, 27 Apr 2005 22:52:55 -0400
User-Agent: KMail/1.7
Cc: David Teigland <teigland@redhat.com>, Steven Dake <sdake@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20050425165826.GB11938@redhat.com> <20050427030217.GA9963@redhat.com> <20050427134142.GZ4431@marowsky-bree.de>
In-Reply-To: <20050427134142.GZ4431@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504272252.55525.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 April 2005 09:41, Lars Marowsky-Bree wrote:
> ...I assume that the delivery of a "node down" membership event
> implies that said node also has been fenced.
>
> So we can't deliver it raw membership events. Noted.

Just to pick a nit: there is no way to be sure a membership event might not 
still be on the way to the dead node, however the rest of the cluster knows 
the node is dead and can ignore it, in theory.  (In practice, only (g)dlm and 
gfs are well glued into the cman membership protocol, and other components, 
e.g., cluster block devices and applications, need to be looked at with 
squinty eyes.)

Regards,

Daniel
