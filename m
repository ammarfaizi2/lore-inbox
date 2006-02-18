Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWBRMZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWBRMZS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWBRMZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:25:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24270 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751188AbWBRMZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:25:17 -0500
Date: Sat, 18 Feb 2006 12:25:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: T?r?k Edwin <edwin.torok@level7.ro>
Cc: netfilter-devel@lists.netfilter.org, fireflier-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, martinmaurer@gmx.at
Subject: Re: [PATCH 2.6.15.4 1/1][RFC] ipt_owner: inode match supporting both incoming and outgoing packets
Message-ID: <20060218122512.GG911@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	T?r?k Edwin <edwin.torok@level7.ro>,
	netfilter-devel@lists.netfilter.org,
	fireflier-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	martinmaurer@gmx.at
References: <200602181410.59757.edwin.torok@level7.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602181410.59757.edwin.torok@level7.ro>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - I need to lock the task_list
> 	- task_list lock export might be gone some day?

yes.  in exactly half a year from now, and no new users are not allowed.

> 	- is locking tasklist when inside a softirq allowed?

no.  for that reason we already removed a broken match from ipt_owner.

