Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbRAKKBa>; Thu, 11 Jan 2001 05:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbRAKKBU>; Thu, 11 Jan 2001 05:01:20 -0500
Received: from mean.netppl.fi ([195.242.208.16]:43535 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S130012AbRAKKBD>;
	Thu, 11 Jan 2001 05:01:03 -0500
Date: Thu, 11 Jan 2001 12:00:48 +0200
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: Tim Sailer <sailer@bnl.gov>
Cc: John Heffner <jheffner@psc.edu>, linux-kernel@vger.kernel.org,
        jfung@bnl.gov
Subject: Re: Network Performance?
Message-ID: <20010111120048.A10115@netppl.fi>
In-Reply-To: <20010109115302.A32135@bnl.gov> <Pine.NEB.4.05.10101091423060.3675-100000@dexter.psc.edu> <20010109155611.B3563@bnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <20010109155611.B3563@bnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 03:56:11PM -0500, Tim Sailer wrote:
> > The defaults must be large unless your application calls setsockopt() to
> > set the buffers itself.  (Some FTP clients and servers can do this, but
> > for testing, your're still probably better always having the _max's and
> > _default's the same.)
> 
> Hm.. OK. I think we tried that, but I'll check again.
And make sure your ftp client/server isn't resetting it to something small
afterwards. For testing this, I'd use a real IP benchmarking program
like iperf/netperf/ttcp, as they'll let you test different buffer sizes
easily (and in the case of iperf tell you what you're actually using
if you hit the limit) For a fast WAN you want something like 
512k-1M buffers easily.

-- 
Pekka Pietikainen



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
