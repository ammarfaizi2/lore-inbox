Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUJNWOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUJNWOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUJNWO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:14:26 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:11014 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267334AbUJNWF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:05:56 -0400
Date: Thu, 14 Oct 2004 23:05:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] move semaphore definitions to waitlock_types.h
Message-ID: <20041014220554.GA14731@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0410142345020.29976@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410142345020.29976@scrub.home>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 11:45:20PM +0200, Roman Zippel wrote:
> 
> This moves the definition and initializer of semaphore, rw_semaphore and
> wait queue structures to waitlock_types.h.

The name is really horrible.  If absolutely needed they should go into
{rwsem,semaphore}_t.h or something similar derived from the main header
names.  But I must say I really hate this kind of separation as it makes
the code rather hard to follow.
