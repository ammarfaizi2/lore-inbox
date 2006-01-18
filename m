Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWARWW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWARWW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWARWW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:22:26 -0500
Received: from kanga.kvack.org ([66.96.29.28]:52186 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932561AbWARWWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:22:25 -0500
Date: Wed, 18 Jan 2006 17:18:11 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: stern@rowland.harvard.edu, akpm@osdl.org, sekharan@us.ibm.com,
       kaos@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] Notifier chain update
Message-ID: <20060118221811.GJ16285@kvack.org>
References: <20060118220122.GH16285@kvack.org> <Pine.LNX.4.44L0.0601181706210.14089-100000@iolanthe.rowland.org> <20060118.141841.87446048.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118.141841.87446048.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 02:18:41PM -0800, David S. Miller wrote:
> If you need to block, take a mutex around the notifier calls.
> (I nearly typed semaphore there, sorry Ingo! :-)

I'm arguing against adding the mutex.  We don't need things like munmap() 
on every cpu doing a down_read() on system wide semaphore.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
