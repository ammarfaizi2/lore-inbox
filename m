Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318880AbSH1QWc>; Wed, 28 Aug 2002 12:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318891AbSH1QWc>; Wed, 28 Aug 2002 12:22:32 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:13187 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318880AbSH1QWb>; Wed, 28 Aug 2002 12:22:31 -0400
Date: Wed, 28 Aug 2002 17:26:42 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Stephen Tweedie <sct@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 5/8] 2.4.20-pre4/ext3: Fix O_SYNC for non-data-journaled modes.
Message-ID: <20020828172642.M2165@redhat.com>
References: <200208281545.g7SFjKE14338@sisko.scot.redhat.com> <20020828171813.A2661@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020828171813.A2661@infradead.org>; from hch@infradead.org on Wed, Aug 28, 2002 at 05:18:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 28, 2002 at 05:18:13PM +0100, Christoph Hellwig wrote:
> On Wed, Aug 28, 2002 at 04:45:20PM +0100, Stephen Tweedie wrote:
> > The fix is to let ext3 put the buffer on the inode queue manually when
> > walking the page's buffer lists in its page write code.
> 
> This patch conflicts with the b_inode as bool patch you recently ACKed..

Do you have a pointer to the most recent version of that patch you
were going to submit?  I've got one final batch of ext3-related things
to submit, containing no bug-fixes but only tweaks and new features
(eg. allowing you to specify the commit interval per-filesystem).  I
can merge the b_inode diff for that batch if you want.

--Stephen
