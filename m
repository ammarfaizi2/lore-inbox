Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVCONjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVCONjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVCONjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:39:46 -0500
Received: from baikonur.stro.at ([213.239.196.228]:55530 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261242AbVCONj3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:39:29 -0500
Date: Tue, 15 Mar 2005 14:39:30 +0100
From: maximilian attems <janitor@sternwelten.at>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [patch] w6692 eliminate bad section references
Message-ID: <20050315133930.GC6680@sputnik.stro.at>
References: <20050313230639.GA24301@sputnik.stro.at> <42360DE5.3000600@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42360DE5.3000600@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Randy.Dunlap wrote:

> maximilian attems wrote:
> >Fix w6692 section references:
> >  convert __initdata to __devinitdata.
> >
> >Error: ./drivers/isdn/hisax/w6692.o .text refers to 0000002f R_386_32
> >.init.data
> >
> I think the correct fix is to make W6692Version() be __init ...
> What do you think of that?
> 
> -- 
> ~Randy

thanks a lot for your review!
you are right much better, added __init to W6692Version().

#Signed-off-by: maximilian attems <janitor@sternwelten.at>

diff -pruN -X dontdiff linux-2.6.11-bk8/drivers/isdn/hisax/w6692.c
linux-2.6.11-bk8-max/drivers/isdn/hisax/w6692.c
--- linux-2.6.11-bk8/drivers/isdn/hisax/w6692.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.11-bk8-max/drivers/isdn/hisax/w6692.c	2005-03-15 14:01:14.000000000 +0100
@@ -49,7 +49,7 @@ static char *W6692Ver[] __initdata =
 {"W6692 V00", "W6692 V01", "W6692 V10",
  "W6692 V11"};
 
-static void
+static void __init
 W6692Version(struct IsdnCardState *cs, char *s)
 {
 	int val;

