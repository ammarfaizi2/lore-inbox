Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSDRKDR>; Thu, 18 Apr 2002 06:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314285AbSDRKDQ>; Thu, 18 Apr 2002 06:03:16 -0400
Received: from [195.39.17.254] ([195.39.17.254]:52364 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314284AbSDRKDQ>;
	Thu, 18 Apr 2002 06:03:16 -0400
Date: Thu, 18 Apr 2002 11:41:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <20020418094128.GA114@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.44L.0204112123480.31387-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> replace slightly obscure while loops with for_each_zone and
> for_each_pgdat macros, this version has the added optimisation
> of skipping empty zones       (thanks to William Lee Irwin)

@@ -501,7 +497,7 @@
        pg_data_t *pgdat = pgdat_list;
        unsigned int sum = 0;

-       do {
+       for_each_pgdat(pgdat) {
                zonelist_t *zonelist = pgdat->node_zonelists +
(GFP_USER & GFP_ZONEMASK);
                zone_t **zonep = zonelist->zones;
                zone_t *zone;

You can kill pgdat initialization here.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
