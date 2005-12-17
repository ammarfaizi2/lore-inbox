Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVLQUip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVLQUip (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVLQUip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:38:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964950AbVLQUik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:38:40 -0500
Date: Sat, 17 Dec 2005 12:38:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git patch review 2/7] IB/mthca: correct log2 calculation
Message-Id: <20051217123816.18ad94e0.akpm@osdl.org>
In-Reply-To: <1134705617067-bb88e1b23a3e36b6@cisco.com>
References: <1134705617067-b51dec64cec55f52@cisco.com>
	<1134705617067-bb88e1b23a3e36b6@cisco.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
> Fix thinko in rd_atomic calculation: ffs(x) - 1 does not find the next
> power of 2 -- it should be fls(x - 1).

Please use round_up_pow_of_two().
