Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271978AbRJBIKd>; Tue, 2 Oct 2001 04:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275856AbRJBIKX>; Tue, 2 Oct 2001 04:10:23 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:26364 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271978AbRJBIKM>; Tue, 2 Oct 2001 04:10:12 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 2 Oct 2001 02:10:01 -0600
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>,
        linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: /dev/random entropy calculations broken?
Message-ID: <20011002021001.A25236@turbolinux.com>
Mail-Followup-To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
In-Reply-To: <1001461026.9352.156.camel@phantasy> <9or70g$i59$1@abraham.cs.berkeley.edu> <tgadzbr8kq.fsf@mercury.rus.uni-stuttgart.de> <20011001105927.A22795@turbolinux.com> <20011002015114.A24826@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011002015114.A24826@turbolinux.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02, 2001  01:51 -0600, Andreas Dilger wrote:
> -	if (r->entropy_count < nbytes*8) {
> +	if (r->entropy_count < nbytes*8 && r->entropy_count < r->poolsize*32) {
                                                                 ^^^^^^^^
Doh!  I hate it when I do that (compile, test, think, edit, send patch
without the compile, test steps).   Should be "poolinfo.poolwords".

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

