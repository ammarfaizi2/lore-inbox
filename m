Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264361AbUEEJs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUEEJs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 05:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbUEEJs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 05:48:27 -0400
Received: from firewall.conet.cz ([213.175.54.250]:54976 "EHLO conet.cz")
	by vger.kernel.org with ESMTP id S264361AbUEEJsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 05:48:12 -0400
Date: Wed, 5 May 2004 11:47:22 +0200
From: Libor Vanek <libor@conet.cz>
To: Paulo Marques <pmarques@grupopie.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
Message-ID: <20040505094722.GA5767@Loki>
References: <20040503000004.GA26707@Loki> <Pine.LNX.4.53.0405030852220.10896@chaos> <20040503150606.GB6411@Loki> <Pine.LNX.4.53.0405032020320.12217@chaos> <20040504011957.GA20676@Loki> <4097E4DD.6090904@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4097E4DD.6090904@grupopie.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 07:45:49PM +0100, Paulo Marques wrote:
> Libor Vanek wrote:
> 
> >Using kernel module:
> >- user space process wants to change some file which is in "snapshoted" dir
> >- my module catches this request, holds it, creates copy of original file 
> >and allows original request to proceed
> 
> 
> Did you take a look at LVM snapshots?
> 
> http://tldp.org/HOWTO/LVM-HOWTO/snapshotintro.html
> 
> Maybe your problem is already solved...

No - this has several disadvantages - mainly you can  snapshot only whole "logical volume" and have preserved space for it (okay - you can add more disks) and it's not very flexible. My approach can even snapshot files to the NFS volume and if you loose primary volume you can still recover some data.
 
> Anyway, you really shouldn't worry about the time it takes to make a 
> context switch when you want to copy a file on modify ;)

Yeah - I'm now convinced that user space daemon is "The Only Right Thing (tm)". I'm now looking how can kernel comunicate with running user-space process.

--
Libor Vanek
