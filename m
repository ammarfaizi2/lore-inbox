Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287478AbSBDDzS>; Sun, 3 Feb 2002 22:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288302AbSBDDzI>; Sun, 3 Feb 2002 22:55:08 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:59805 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S287478AbSBDDyw>; Sun, 3 Feb 2002 22:54:52 -0500
Date: Sun, 3 Feb 2002 22:59:05 -0500
To: Momchil Velikov <velco@fadata.bg>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020204035905.GA8208@earthlink.net>
In-Reply-To: <20020202192334.GA21556@earthlink.net> <877kpuw37k.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877kpuw37k.fsf@fadata.bg>
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 01:33:19AM +0200, Momchil Velikov wrote:
> Hmm, I've got different results with bonnie++, are you sure you didn't
> swap the results :)

I don't think so, but I notice that bonnie++ Sequential and Random Create 
tests flucuate a lot.  These are on 16384 small files in my tests.

                ------Sequential Create------ --------Random Create--------
                -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
          files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
2.4.17       16  4217  97 +++++ +++  4664  99  4354  99 +++++ +++  4090  95
             16  4423  99 +++++ +++  4266  90  4404  95 +++++ +++  4382 100
             16  4468  97 +++++ +++  4899  99  4522  99 +++++ +++  4235  95
             16  4498  96 +++++ +++  4777 100  4464  99 +++++ +++  3854  90
             16  4503  95 +++++ +++  4990  99  4632  98 +++++ +++  4058  90

2.4.17rat    16  2994  98 +++++ +++  4548  94  2952  99 +++++ +++  3967  92
             16  3055  97 +++++ +++  4705  93  4665  99 +++++ +++  4119  94
             16  4463  96 +++++ +++  4670 100  4452 100 +++++ +++  3775  94
             16  4833  99 +++++ +++  4823 100  4616  97 +++++ +++  4054  92
             16  4521  98 +++++ +++  3907  88  4329  95 +++++ +++  4111 100

The test against a 1GB (large) file vary somewhat too, but not as much as
the tests above.  The results I posted earlier were the averages from 5 runs.

I just uploaded the raw logfiles from my testing (not just 2.4.17 and radix-tree)
to http://home.earthlink.net/~rwhron/kernel  (the tar.bz2 files are the logs).

-- 
Randy Hron

