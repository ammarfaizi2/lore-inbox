Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030552AbWBHXT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbWBHXT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030534AbWBHXT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:19:59 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5797 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030529AbWBHXT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:19:58 -0500
Date: Wed, 8 Feb 2006 15:19:54 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: linux-kernel@vger.kernel.org
cc: ebiederm@xmission.com, oleg@tv-sign.ru, mm-commits@vger.kernel.org
Subject: Re: + fork-allow-init-to-become-a-session-leader.patch added to -mm
 tree
In-Reply-To: <200602082314.k18NEuN0017390@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.62.0602081518580.5184@schroedinger.engr.sgi.com>
References: <200602082314.k18NEuN0017390@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006 akpm@osdl.org wrote:

> +			if (unlikely(p->pid == 1)) {
> +				p->signal->tty = NULL;
> +				p->signal->leader = 1;
> +				p->signal->pgrp = 1;
> +				p->signal->session = 1;

Would it not be better to do these special settings for init from 
init itself?
