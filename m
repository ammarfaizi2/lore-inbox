Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTEMVFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTEMVFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:05:49 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:2316 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262093AbTEMVFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:05:47 -0400
Date: Tue, 13 May 2003 22:18:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: mjacob@quaver.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4 fix to allow vmalloc at interrupt time
Message-ID: <20030513221831.A11880@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, mjacob@quaver.net,
	linux-kernel@vger.kernel.org
References: <20030512225654.GA27358@cm.nu> <20030513140629.I83125@mailhost.quaver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030513140629.I83125@mailhost.quaver.net>; from mjacob@feral.com on Tue, May 13, 2003 at 02:11:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 02:11:12PM -0700, Matthew Jacob wrote:
> 
> This fixes a buglet wrt doing vmalloc at interrupt time for 2.4.

vmalloc/vfree is not allowed from interrupt context.  the GFP flag
is the least of your worries.

