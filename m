Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVIXAT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVIXAT7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 20:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVIXAT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 20:19:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38370 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750827AbVIXAT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 20:19:59 -0400
Date: Sat, 24 Sep 2005 01:19:58 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce sizeof(struct file)
Message-ID: <20050924001958.GJ7992@ftp.linux.org.uk>
References: <17AB476A04B7C842887E0EB1F268111E026FC5@xpserver.intra.lexbox.org> <4333CF4C.2000306@anagramm.de> <4333D2AA.6020009@cosmosbay.com> <20050923100541.GA18447@infradead.org> <20050924013021.1130f3c8@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050924013021.1130f3c8@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 01:30:21AM +0200, J.A. Magallon wrote:
> How about anonymous unions ? gcc-3.3.3 and above support them.
> Is 2.6 supposed to be built with 2.95 ?

NAK.  For one thing, yes, it is supposed to be built with 2.95.  For
another, they do not buy you anything - few enough places use either
field, so there is no point in hiding that union.
