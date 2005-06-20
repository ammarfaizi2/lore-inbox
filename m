Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVFTVX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVFTVX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVFTVVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:21:06 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:56585 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261541AbVFTVLb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:11:31 -0400
Date: Mon, 20 Jun 2005 23:11:47 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mchehab@brturbo.com.br, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: 2.6.12-mm1
Message-Id: <20050620231147.7232d889.khali@linux-fr.org>
In-Reply-To: <20050620134146.0e5de567.akpm@osdl.org>
References: <20050619233029.45dd66b8.akpm@osdl.org>
	<20050620202947.040be273.khali@linux-fr.org>
	<20050620134146.0e5de567.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> > No, Mauro. This patch is necessary to fix something YOU just broke
> > with your previous patch. So please learn how to make correct
> > patches that don't randomly revert previous changes. This will make
> > everyone's life easier, including Andrew's, Greg's and mine.
> 
> Yup.  This sort of thing often happens when teams run parallel CVS
> trees.

I don't see how this is relevant. People may use whatever they want as
their playground when working on the code, but are required to provide
clean patches when they want their changes to be merged in. I don't even
ask for patches against a bleeding-edge tree - just *clean* patches, not
reverting anything or otherwise including unwanted changes. Andrew, I
believe you have enough work to do as it is without adding the burden of
doubling the amount of patches you have to work with, and requiring you
to merge patches yourself before you send them to Linus.

> I don't think anything needs to be done by Mauro in this case.  Once
> Greg's patches are merged up I'll fold the two fixes into the v4l
> patches then send them off to Linus and everything will come out
> squeaky clean.

There *is* something Mauro needs to do, that is, provide clean patches.
The fact that they revert a change from Greg's patches is irrelevant
here. It could as well be in Linus' tree already (it will be soon).

What I suspect Mauro did is: start from kernel tree X, work on it, then
provide a diff against tree X+1 and X + his own changes. Whether X is
some CVS repository and X+1 is an official tree doesn't really matter.
What matters is that this working model is fundamentally broken. You
must *always* generate patches between X and X + your changes, whatever
X is. I don't think it's really hard to understand, and do.

Thanks,
-- 
Jean Delvare
