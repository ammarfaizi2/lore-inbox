Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261343AbTCJQ2z>; Mon, 10 Mar 2003 11:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261344AbTCJQ2z>; Mon, 10 Mar 2003 11:28:55 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:28816 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S261343AbTCJQ2y>; Mon, 10 Mar 2003 11:28:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <bzzz@tmi.comex.ru>
Subject: Re: [PATCH] concurrent block allocation for ext3
Date: Mon, 10 Mar 2003 17:43:06 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
References: <m3zno3grfz.fsf@lexa.home.net> <20030310092546.D12806@schatzie.adilger.int>
In-Reply-To: <20030310092546.D12806@schatzie.adilger.int>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030310163911.87F29E9F17@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10 Mar 03 17:25, Andreas Dilger wrote:
> One minor nit is that you left an ext3_error() for the "bit already
> cleared" case just above this patch hunk.

But that one belongs there, because no two threads should be trying to free 
the same block at the same time.

Regards,

Daniel
