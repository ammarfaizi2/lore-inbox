Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVI0Seu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVI0Seu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVI0Seu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:34:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25321 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965009AbVI0Set (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:34:49 -0400
Date: Tue, 27 Sep 2005 19:34:30 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       Alasdair G Kergon <agk@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Writing on DM snapshots, and having no "mainstream" device (was: Re: Fw: [PATCH 1/7] Add dm-snapshot tutorial in Documentation)
Message-ID: <20050927183430.GN18976@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Blaisorblade <blaisorblade@yahoo.it>,
	user-mode-linux-devel@lists.sourceforge.net,
	LKML <linux-kernel@vger.kernel.org>,
	user-mode-linux-user@lists.sourceforge.net
References: <20050920163433.6081be3b.akpm@osdl.org> <200509232211.32238.blaisorblade@yahoo.it> <20050923211953.GG18976@agk.surrey.redhat.com> <200509261703.01567.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509261703.01567.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 05:03:01PM +0200, Blaisorblade wrote:
> You also "fixed" my assertion that snapshot-origin "base device" (parameter 
> n.1) must be a DM device. Should I readd it too?
 
That parameter does not need to be a DM device if you are able to use
the start of an existing block device (so you don't require any mappings).

> IIRC I checked the code and it looks up the first param as a DM device, 

It should only use the device number for reference, not any dm structure.

Try it.

Alasdair
-- 
agk@redhat.com
