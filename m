Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbWBDXwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWBDXwF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWBDXvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:51:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030199AbWBDXvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:51:25 -0500
Date: Sat, 4 Feb 2006 15:50:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, pj@sgi.com, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060204155027.756bd372.akpm@osdl.org>
In-Reply-To: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  +static inline int is_mem_spread(const struct cpuset *cs)
>  +{
>  +	return !!test_bit(CS_MEM_SPREAD, &cs->flags);
>  +}

The !!  doesn't seem needed.  The name of this function implies that it
returns a boolean, not a scalar.

