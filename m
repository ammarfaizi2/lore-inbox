Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264968AbSJVT3E>; Tue, 22 Oct 2002 15:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSJVT3D>; Tue, 22 Oct 2002 15:29:03 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:18695 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264968AbSJVT27>; Tue, 22 Oct 2002 15:28:59 -0400
Date: Tue, 22 Oct 2002 20:35:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre11 /proc/partitions read
Message-ID: <20021022203504.A7770@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries Brouwer <aebr@win.tue.nl>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Jan Kasprzak <kas@informatics.muni.cz>,
	linux-kernel@vger.kernel.org
References: <20021022185958.GB26585@win.tue.nl> <Pine.LNX.4.44L.0210221625440.27942-100000@freak.distro.conectiva> <20021022193226.GC26585@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021022193226.GC26585@win.tue.nl>; from aebr@win.tue.nl on Tue, Oct 22, 2002 at 09:32:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 09:32:26PM +0200, Andries Brouwer wrote:
> On Tue, Oct 22, 2002 at 04:26:35PM -0200, Marcelo Tosatti wrote:
> 
> > > No.  I do not claim that his problem was caused by the stats.
> > > It is just that I get reports from people with mysterious mount
> > > and fdisk problems that go away when CONFIG_BLK_STATS is disabled.
> > 
> > Could you forward?
> > 
> > Thats really bad.
> 
> The best reference is
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=35980
> 
> with fsck affected.
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=62414
> 
> shows that mount is affected.

Both of those should be fixed by my patch, i.e. were caused by a bug
in fpos handling in the seq_file /proc/partions.  There is nothing
about the statistics in them.

