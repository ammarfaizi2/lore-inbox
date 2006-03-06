Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752190AbWCFIXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbWCFIXj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWCFIXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:23:39 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:44657 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752164AbWCFIXi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:23:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l3QAULJFBscGtMpjHAUnzbV8+nQr68ms5bYdXK3eQKk+659qE1AFEVSoxNGuUqa7K+8JACqExtVkZNU/MtZ8QFGWL9jEpb87eYFvjlkpDMHzd956xM9ghspPRlaQm2eBSeKivd6nwaKG8oPvpPUOyQrkRLO52YA7+SzShqpS/g4=
Message-ID: <84144f020603060023s236c7221i3d6b20b6c7132ef4@mail.gmail.com>
Date: Mon, 6 Mar 2006 10:23:36 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: 9pfs double kfree
Cc: "Dave Jones" <davej@redhat.com>, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, ericvh@gmail.com, rminnich@lanl.gov
In-Reply-To: <20060306081651.GG27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060306070456.GA16478@redhat.com>
	 <20060305.230711.06026976.davem@davemloft.net>
	 <20060306072346.GF27946@ftp.linux.org.uk>
	 <20060306072823.GF21445@redhat.com>
	 <84144f020603052356r321bc78dp66263fbfc73517c6@mail.gmail.com>
	 <20060306081651.GG27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> Legal, but rather bad taste.  Init to NULL, possibly assign the value
> if kmalloc(), then kfree() unconditionally - sure, but that... almost
> certainly one hell of a lousy cleanup logics somewhere.

Agreed.

                                 Pekka
