Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270865AbTHFR26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270871AbTHFR26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:28:58 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:50436
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270869AbTHFR2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:28:17 -0400
Date: Wed, 6 Aug 2003 10:28:13 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Oleg Drokin <green@namesys.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] reiserfs: fix locking in reiserfs_remount
Message-ID: <20030806172813.GB21290@matchmail.com>
Mail-Followup-To: Oleg Drokin <green@namesys.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20030806093858.GF14457@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806093858.GF14457@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 01:38:58PM +0400, Oleg Drokin wrote:
> Hello!
> 
>     Since reiserfs_remount can be called without BKL held, we better take BKL in there.
>     Please apply the below patch. It is against 2.6.0-test2

is the BKL in reiserfs_write_unlock()?

Do we need to be adding more BKL usage, instead of the same or less at this
point?
