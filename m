Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSD3TUM>; Tue, 30 Apr 2002 15:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSD3TUL>; Tue, 30 Apr 2002 15:20:11 -0400
Received: from imladris.infradead.org ([194.205.184.45]:63238 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315178AbSD3TUL>; Tue, 30 Apr 2002 15:20:11 -0400
Date: Tue, 30 Apr 2002 20:20:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre7aa3
Message-ID: <20020430202010.A16236@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020430203154.B11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 08:31:54PM +0200, Andrea Arcangeli wrote:
> Only in 2.4.19pre7aa3: 00_wake_up_page-1
> 
> 	Reintroduced wake_up_page (not deadlock prone anymore), for modules
> 	that were waking up pages.

For what module?  (Don't say a agp/drm upgrade!)  As the person who invented
wake_up_page I can't really see a good reason for it anymore.  Every single
caller should have used unlock_page() instead.
