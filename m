Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268364AbRGXRIM>; Tue, 24 Jul 2001 13:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268366AbRGXRID>; Tue, 24 Jul 2001 13:08:03 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17673 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268364AbRGXRHt>; Tue, 24 Jul 2001 13:07:49 -0400
Date: Tue, 24 Jul 2001 14:07:32 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <010301c11463$1ee00440$294b82ce@connecttech.com>
Message-ID: <Pine.LNX.4.33L.0107241405230.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

[ CC: to linux-kernel added back since the topic isn't flammable ;) ]

On Tue, 24 Jul 2001, Stuart MacDonald wrote:
> From: "Rik van Riel" <riel@conectiva.com.br>
> > If a page gets 2 1-byte reads in a microsecond, with this
> > patch it would get promoted to the active list, even though
> > it's really only used once.
>
> I hate to bother you directly, but I don't wish to start a flame
> war on lkml. How exactly would you explain two accesses as
> being "used once"?

Because they occur in a very short interval, an interval MUCH
shorter than the time scale in which the VM subsystem looks at
referenced bits, etc...

Generally a CPU doesn't read more than one cache line at a time,
so I guess all "single references" are in reality multiple
accesses very shortly following each other.

This seems to be generally accepted theory and practice in the
field of page replacement.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

