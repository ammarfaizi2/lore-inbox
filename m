Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266559AbUAWOPc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 09:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUAWOPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 09:15:32 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:24233 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266559AbUAWOPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 09:15:32 -0500
Date: Fri, 23 Jan 2004 14:13:53 +0000
From: Dave Jones <davej@redhat.com>
To: Evaldo Gardenali <evaldo@gardenali.biz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: buggy raid checksumming selection?
Message-ID: <20040123141352.GA19002@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Evaldo Gardenali <evaldo@gardenali.biz>,
	linux-kernel@vger.kernel.org
References: <40112465.8040801@gardenali.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40112465.8040801@gardenali.biz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 11:40:53AM -0200, Evaldo Gardenali wrote:

 > Uhh. correct me if I am wrong, but shouldnt it select the fastest algorithm?

No, if it can choose a function which avoids polluting the cache over
one that doesn't, it will.  Even if that means slightly less raw throughput

This comes up time after time, maybe we need a printk in that case ?

	Dave

