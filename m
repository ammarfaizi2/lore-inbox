Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131025AbRCWPO7>; Fri, 23 Mar 2001 10:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbRCWPOt>; Fri, 23 Mar 2001 10:14:49 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:49088 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131025AbRCWPOh>;
	Fri, 23 Mar 2001 10:14:37 -0500
Message-ID: <3ABB6833.183E9188@mandrakesoft.com>
Date: Fri, 23 Mar 2001 10:13:55 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: General 2.4 impressions (was Re: [PATCH] Prevent OOM from killing init)
In-Reply-To: <20010323015358Z129164-406+3041@vger.kernel.org> <Pine.LNX.4.21.0103230403370.29682-100000@imladris.rielhome.conectiva> <20010323122815.A6428@win.tue.nl> <m1hf0k1qvi.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Personally I think the OOM killer itself is fine.  I think there are
problems elsewhere which are triggering the OOM killer when it should
not be triggered, ie. a leak like Doug Ledford was reporting.

I definitely see heavier page/dcache usage in 2.4 -- but that is to be
expected due to 2.4 changes!  So it is incredibily difficult to quantify
if something is wrong, and if so, where...

My own impressions of 2.4 are that it "feels faster" for my own uses and
it's stable.  The downsides I find are that heavy fs activity seems to
imply increased swapping, which jibes with a guess that the page/dcache
is exceptionally greedy with releasing pages under memory pressure.

</unquantified vague ramble>

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
