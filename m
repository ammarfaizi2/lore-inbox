Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288962AbSATT6F>; Sun, 20 Jan 2002 14:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSATT5z>; Sun, 20 Jan 2002 14:57:55 -0500
Received: from mail.zmailer.org ([194.252.70.162]:16768 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S288957AbSATT5k>;
	Sun, 20 Jan 2002 14:57:40 -0500
Date: Sun, 20 Jan 2002 21:57:28 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: John Jasen <jjasen1@umbc.edu>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Andrew Morton <akpm@zip.com.au>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
Message-ID: <20020120215728.B1112@mea-ext.zmailer.org>
In-Reply-To: <20020120193141.A1112@mea-ext.zmailer.org> <Pine.SGI.4.31L.02.0201201422500.1767115-100000@irix2.gl.umbc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.31L.02.0201201422500.1767115-100000@irix2.gl.umbc.edu>; from jjasen1@umbc.edu on Sun, Jan 20, 2002 at 02:24:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 02:24:40PM -0500, John Jasen wrote:
> Really?
>   Software raid?
> I have a quad ppro that is doing ext3/md just fine, and its running
> 2.4.17.

  Indeed. I didn't have problems with dual PPro200, but after I did
  upgrade it to dual P-III-750, it does hang up.  Machines have
  128 MB, and 750 MB memory, respectively.  (Disks and host controller
  were moved over.)

  I recall having ran same earlier PPro optimized 2.4 kernel on PPro200,
  and on P-III (2.4.6-ac1, or 2.4.10).  It hung up too, which prompted 
  research on kernel versions.

  This all does point to some sort of deadlock window somewhere.
  It appears to be practically untriggerable with PPro200, but
  trivial to hit with P-III-750.

  Now to have a reliable way to find where the CPUs are spinning
  when the thing does not work...  (I have tested kdb: keyboard
  dies at hangup -> kdb becomes non-functional...)

> --
> -- John E. Jasen (jjasen1@umbc.edu)
> -- In theory, theory and practise are the same. In practise, they aren't.

/Matti Aarnio
