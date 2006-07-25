Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWGYLzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWGYLzB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 07:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWGYLzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 07:55:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45385 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932338AbWGYLzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 07:55:00 -0400
Date: Tue, 25 Jul 2006 13:29:57 +0200
From: Jens Axboe <axboe@suse.de>
To: gmu 2k6 <gmu2006@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
Message-ID: <20060725112955.GR4044@suse.de>
References: <20060725073208.GA10601@suse.de> <f96157c40607250100x3850ffb7g1d2ed300529661f1@mail.gmail.com> <20060725074107.GA4044@suse.de> <f96157c40607250120s2554cbc6qbd7c42972b70f6de@mail.gmail.com> <20060725080002.GD4044@suse.de> <f96157c40607250128h279d6df7n8e86381729b8aa97@mail.gmail.com> <20060725080807.GF4044@suse.de> <f96157c40607250217o1084b992u78083353032b9abc@mail.gmail.com> <f96157c40607250220h13abfd6av2b532cae70745d2@mail.gmail.com> <f96157c40607250235t4cdd76ffxfd6f95389d2ddbdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96157c40607250235t4cdd76ffxfd6f95389d2ddbdc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25 2006, gmu 2k6 wrote:
> ok, let's nail it to 2.6.17-git5 instead as it survived git status
> compared to -git6
> which seems to have correctly booted by accident the lastime. timing issues
> I guess.

I will try and reproduce it here now. It seems to be in between commit
271f18f102c789f59644bb6c53a69da1df72b2f4 and commit
dd67d051529387f6e44d22d1d5540ef281965fdd where the first one could also
be bad.

I'm assuming that acf421755593f7d7bd9352d57eda796c6eb4fa43 should be
good, so you can try and verify that
dd67d051529387f6e44d22d1d5540ef281965fdd is bad and bisect between the
two. It's only about 6 commits, so should be quick enough to do.

-- 
Jens Axboe

