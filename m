Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270874AbTGVVnp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 17:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270884AbTGVVnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 17:43:45 -0400
Received: from gw.uk.sistina.com ([62.172.100.98]:42509 "EHLO
	gw.uk.sistina.com") by vger.kernel.org with ESMTP id S270874AbTGVVno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 17:43:44 -0400
Date: Tue, 22 Jul 2003 22:58:44 +0100
From: Alasdair G Kergon <agk@uk.sistina.com>
To: dm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [RFC] File backed target for device-mapper
Message-ID: <20030722225844.T31325@uk.sistina.com>
Mail-Followup-To: dm-devel@sistina.com, linux-kernel@vger.kernel.org
References: <1058908659.17049.9.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1058908659.17049.9.camel@chtephan.cs.pocnet.net>; from christophe@saout.de on Tue, Jul 22, 2003 at 11:17:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 11:17:39PM +0200, Christophe Saout wrote:
> I just wrote a dm target uses a file as backend instead of another block
> device.

Another suggestion:

  A target that always returns a block of zeros [or more generally,
  some other repeating pattern e.g. if the read goes beyond the end
  of your file - required to be multiple of sector size - it loops 
  round to the beginning; writes get dropped]

So you can easily create, for example a /dev/zero-like block device of
arbitrary size, which might be useful for replacing a lost disk that
contained a stripe if you want to read off the data from the other
stripes at correct offsets.

Alasdair
-- 
agk@uk.sistina.com
