Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRATTGA>; Sat, 20 Jan 2001 14:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRATTFv>; Sat, 20 Jan 2001 14:05:51 -0500
Received: from ns.caldera.de ([212.34.180.1]:60166 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129413AbRATTFj>;
	Sat, 20 Jan 2001 14:05:39 -0500
Date: Sat, 20 Jan 2001 20:05:15 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Rajagopal Ananthanarayanan <ananth@sgi.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic IO write clustering
Message-ID: <20010120200514.A26170@caldera.de>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Rajagopal Ananthanarayanan <ananth@sgi.com>,
	Rik van Riel <riel@conectiva.com.br>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010120184506.A21943@caldera.de> <Pine.LNX.4.21.0101201358340.6593-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0101201358340.6593-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sat, Jan 20, 2001 at 02:00:24PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 02:00:24PM -0200, Marcelo Tosatti wrote:
> > True.  But you have to go through ext2_get_branch (under the big kernel
> > lock) - if we can do only one logical->physical block translations,
> > why doing it multiple times?
> 
> You dont. If the metadata is cached and uptodate there is no need to call
> get_block().

Ups.  You are right for the stock tree - I was only looking at my kio tree,
where it can't be cached due to the lack of buffer-cache usage...

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
