Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSIEGtd>; Thu, 5 Sep 2002 02:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSIEGtc>; Thu, 5 Sep 2002 02:49:32 -0400
Received: from bof.de ([195.4.223.10]:39572 "HELO oknodo.bof.de")
	by vger.kernel.org with SMTP id <S317101AbSIEGtc>;
	Thu, 5 Sep 2002 02:49:32 -0400
Date: Thu, 5 Sep 2002 08:51:03 +0200
From: Patrick Schaaf <bof@bof.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, Harald Welte <laforge@gnumonks.org>,
       Netfilter Mailing List <netfilter-devel@lists.netfilter.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Schaaf <bof@bof.de>
Subject: Re: ip_conntrack_hash() problem
Message-ID: <20020905085103.G19551@oknodo.bof.de>
References: <20020904152626.A11438@wotan.suse.de> <20020905044436.0772A2C0DF@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020905044436.0772A2C0DF@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Sep 05, 2002 at 10:39:40AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty,

> This work is already done:
> http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Netfilter/conntrack_hashing.patch.gz

Regarding the rehash check in ip_conntrack_find_get, wouldn't it be
better to do that in the confirm function, where a new conntrack
is put into the list? That's called a lot less often than _find_get,
and should be logically equivalent. IOW, why wait until we _find_
an overly long list, when we can rehash at the point in time when
it _became_ overly long?

best regards
  Patrick

