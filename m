Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132710AbRDCWxk>; Tue, 3 Apr 2001 18:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132711AbRDCWxb>; Tue, 3 Apr 2001 18:53:31 -0400
Received: from mail2.panix.com ([166.84.0.213]:32497 "HELO mail2.panix.com")
	by vger.kernel.org with SMTP id <S132710AbRDCWxV>;
	Tue, 3 Apr 2001 18:53:21 -0400
Date: Tue, 3 Apr 2001 18:48:06 -0400 (EDT)
From: Harvey Fishman <fishman@panix.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jurgen Kramer <GTM.Kramer@inter.nl.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2048 byte/sector problems with kernel 2.4
In-Reply-To: <E14kYoO-0000Wy-00@the-village.bc.nu>
Message-ID: <Pine.SUN.4.21.0104031840540.413-100000@panix5.panix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2001, Alan Cox wrote:

> > I also tried it with 2.2.18 there it works but it seems to be utterly
> > slow. I'm using kernel 2.4.2(XFS version to be precise).
> 
> M/O disks are slow. At a minimum make sure you are using a physical block size
> of 2048 bytes when using 2048 byte media and plenty of memory to cache stuff
> when reading. Seek times on M/O media are pretty poor

Another thing making for the snailicity of MO drives is that writing is a
two pass operation.  It is very like core memory; first you write the spot
to a known state, and then you write the data.  So you have an average 
latency of 25 mS. for write operations and 8.33 mS. for read operations.
There WERE direct overwrite media for a while that would, in theory, be
able to write the data directly, but a combination of high cost, limited
sources, and strong questions about the permanence of the recorded data
severely limited the demand for these and I think that they have been
withdrawn.

Harvey

----------------------------------------------------------------------------
 Harvey Fishman   |
fishman@panix.com |           A little heresy is good for the soul.
  718-258-7276    |

