Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262912AbSJWIeF>; Wed, 23 Oct 2002 04:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262979AbSJWIeF>; Wed, 23 Oct 2002 04:34:05 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:56964 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S262912AbSJWIeE>;
	Wed, 23 Oct 2002 04:34:04 -0400
Date: Wed, 23 Oct 2002 10:39:22 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Christoph Hellwig <hch@infradead.org>, Andries Brouwer <aebr@win.tue.nl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre11 /proc/partitions read
Message-ID: <20021023103922.C20511@fi.muni.cz>
References: <20021022185958.GB26585@win.tue.nl> <Pine.LNX.4.44L.0210221625440.27942-100000@freak.distro.conectiva> <20021022193226.GC26585@win.tue.nl> <20021022203504.A7770@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021022203504.A7770@infradead.org>; from hch@infradead.org on Tue, Oct 22, 2002 at 08:35:04PM +0100
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
: Both of those should be fixed by my patch, i.e. were caused by a bug
: in fpos handling in the seq_file /proc/partions.  There is nothing
: about the statistics in them.

	The problem is that without statistics, the /proc/partitions
contents is a *lot* smaller, so it probably fits in a single 1024-byte read()
syscall. So having stats in /proc/partitions only increases the probability
of this problem. I'll try your patch and let you know then.

-Y.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|-- If you start doing things because you hate others and want to screw  --|
|-- them over the end result is bad.   --Linus Torvalds to the BBC News  --|
