Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264965AbSJWNDu>; Wed, 23 Oct 2002 09:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264967AbSJWNDu>; Wed, 23 Oct 2002 09:03:50 -0400
Received: from rth.ninka.net ([216.101.162.244]:11414 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S264965AbSJWNDt>;
	Wed, 23 Oct 2002 09:03:49 -0400
Subject: Re: [RESEND] tuning linux for high network performance?
From: "David S. Miller" <davem@rth.ninka.net>
To: bert hubert <ahu@ds9a.nl>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20021023130101.GA646@outpost.ds9a.nl>
References: <200210231218.18733.roy@karlsbakk.net>
	<200210231306.18422.roy@karlsbakk.net> 
	<20021023130101.GA646@outpost.ds9a.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 06:21:48 -0700
Message-Id: <1035379308.5950.3.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 06:01, bert hubert wrote:
> Also mention that you have an e1000 card which
> does not do outgoing checksumming.

The e1000 can very well do hardware checksumming on transmit.

The missing piece of the puzzle is that his application is not
using sendfile(), without which no transmit checksum offload
can take place.

