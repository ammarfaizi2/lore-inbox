Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWITHo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWITHo7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 03:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWITHo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 03:44:59 -0400
Received: from cantor2.suse.de ([195.135.220.15]:26768 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751271AbWITHo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 03:44:58 -0400
From: Andi Kleen <ak@suse.de>
To: Dmitriy Zavin <dmitriyz@google.com>
Subject: Re: [PATCH 2/4] jiffies: Add 64bit jiffies compares (needed when long < 64bit).
Date: Wed, 20 Sep 2006 09:40:38 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <11587201623432-git-send-email-dmitriyz@google.com> <11587201623187-git-send-email-dmitriyz@google.com> <11587201621900-git-send-email-dmitriyz@google.com>
In-Reply-To: <11587201621900-git-send-email-dmitriyz@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609200940.38356.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#define time_after64(a,b)		\
> +	(typecheck(__u64, a) && \
> +	 typecheck(__u64, b) && \

Did you double check the typecheck DTRT when someone
passes in both plain long and long long on 64bit?

-Andi

