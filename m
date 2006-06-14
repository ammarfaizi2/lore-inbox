Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWFNAnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWFNAnh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWFNAnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:43:37 -0400
Received: from relay01.pair.com ([209.68.5.15]:6926 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S932343AbWFNAng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:43:36 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 03/11] Task watchers:  Refactor process events
Date: Tue, 13 Jun 2006 19:43:12 -0500
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
References: <20060613235122.130021000@localhost.localdomain> <1150242879.21787.143.camel@stark>
In-Reply-To: <1150242879.21787.143.camel@stark>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606131943.34800.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 18:54, Matt Helsley wrote:

> +	WARN_ON((which_id != PROC_EVENT_UID) && (which_id != PROC_EVENT_GID));
>  }

How about WARN_ON(!(which_id & (PROC_EVENT_UID | PROC_EVENT_GID))) to save a 
cmp?

Thanks,
Chase
