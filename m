Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbTLVXuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264594AbTLVXuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:50:55 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:23968 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264591AbTLVXux
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:50:53 -0500
Date: Mon, 22 Dec 2003 15:50:40 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Joe Thornber <thornber@sistina.com>
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
Message-ID: <20031222235040.GU6438@matchmail.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Fruhwirth Clemens <clemens@endorphin.org>,
	Joe Thornber <thornber@sistina.com>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net> <20031222215236.GB13103@leto.cs.pocnet.net> <3FE7794D.7000908@pobox.com> <20031222232433.GT6438@matchmail.com> <3FE77E49.4010303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE77E49.4010303@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 06:29:13PM -0500, Jeff Garzik wrote:
> Mike Fedyk wrote:
> >Do you dislike the cryptoloop format?
> >
> >What if you wanted to take a disk that was used with dm-crypt, and copy it
> >to a file on a larger filesystem?  Would the data now be inaccessable
> >because it's not in a format mountable by a loop driver?
> 
> Remember we are talking about two -totally different- drivers here.
> 
> I can't take my reiserfs data, copy it to a file on a larger filesystem, 
> and then mount it with ext3.  And that's a good thing.
> 

Aww, why not? ;)

> dm-crypt should not be constrained by cryptoloop, and vice versa.

It seems dm-crypt was meant to overcome the problems with loop against block
devices.  If it uses another format, it would loose that ability to be a
replacement, and unless there are shortcomings in the format, why should
there be a change?

Also, while cryptoloop on block devices may be bass ackwards to get
encryption (use a driver meant to turn files into block devices on another
block device since there is now crypto tied into it...), if there's another
format, won't that data become inaccessable unless it's in a block device,
or do you get the dm-crypt -> loop -> file in the case a dm-crypt image gets
copied to a file?
