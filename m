Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314653AbSEKJaI>; Sat, 11 May 2002 05:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314654AbSEKJaH>; Sat, 11 May 2002 05:30:07 -0400
Received: from imladris.infradead.org ([194.205.184.45]:48140 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314653AbSEKJaG>; Sat, 11 May 2002 05:30:06 -0400
Date: Sat, 11 May 2002 10:23:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org,
        kaos@ocs.com.au
Subject: Re: [PATCH] iget-locked [2/6]
Message-ID: <20020511102348.B24305@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@math.psu.edu>,
	Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org,
	kaos@ocs.com.au
In-Reply-To: <20020511030437.GA29392@ravel.coda.cs.cmu.edu> <Pine.GSO.4.21.0205102317410.20383-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 11:44:23PM -0400, Alexander Viro wrote:
> As for the binary compatibility... as long as we are source-compatible
> (i.e. keep ->read_inode2 and provide a compatible iget4()) - compatibility
> is not a problem.  Anyone who ships binary-only modules is playing in the
> traffic and if they become a roadkill - it's Not Our Problem(tm).  Think
> of it as evolution in action...

We need to keep iget4, but I don't think keeping ->read_inode2 source
compatiblitly is needed, it always was marked as a reiserfs cludge and
no one was supposed to use it.

