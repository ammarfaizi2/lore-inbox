Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161156AbVKQHNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbVKQHNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 02:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbVKQHNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 02:13:36 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:3798
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161156AbVKQHNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 02:13:36 -0500
Date: Wed, 16 Nov 2005 23:13:37 -0800 (PST)
Message-Id: <20051116.231337.113983448.davem@davemloft.net>
To: akpm@osdl.org
Cc: jordan.crouse@amd.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Fix poor pointer math in devinet_sysctl_register
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051116221412.7ecea148.akpm@osdl.org>
References: <20051116232345.GA872@cosmic.amd.com>
	<20051116221412.7ecea148.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 16 Nov 2005 22:14:12 -0800

> "Jordan Crouse" <jordan.crouse@amd.com> wrote:
> >  @@ -1454,7 +1454,7 @@ static void devinet_sysctl_register(stru
> >   		return;
> >   	memcpy(t, &devinet_sysctl, sizeof(*t));
> >   	for (i = 0; i < ARRAY_SIZE(t->devinet_vars) - 1; i++) {
> >  -		t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf;
> >  +		t->devinet_vars[i].data += (int)((char *)p - (char *)&ipv4_devconf);
> 
> Confused.  These appear to be equivalent (on 32-bit CPUs, anyway).

Indeed, please describe the exact failure case when posting
such patches.
