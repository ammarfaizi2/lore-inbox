Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWCYE0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWCYE0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWCYE0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:26:41 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:25020
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750813AbWCYE0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:26:40 -0500
Date: Fri, 24 Mar 2006 20:26:18 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Hans Verkuil <hverkuil@xs4all.nl>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 02/20] V4L/DVB (3324): Fix Samsung tuner frequency ranges
Message-ID: <20060325042618.GC21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="v4l-dvb-fix-samsung-tuner-frequency-ranges.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Hans Verkuil <hverkuil@xs4all.nl>

Forgot to take the NTSC frequency offset into account.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/media/video/tuner-types.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16.orig/drivers/media/video/tuner-types.c
+++ linux-2.6.16/drivers/media/video/tuner-types.c
@@ -1087,8 +1087,8 @@ static struct tuner_params tuner_tnf_533
 /* ------------ TUNER_SAMSUNG_TCPN_2121P30A - Samsung NTSC ------------ */
 
 static struct tuner_range tuner_samsung_tcpn_2121p30a_ntsc_ranges[] = {
-	{ 16 * 175.75 /*MHz*/, 0x01, },
-	{ 16 * 410.25 /*MHz*/, 0x02, },
+	{ 16 * 130.00 /*MHz*/, 0x01, },
+	{ 16 * 364.50 /*MHz*/, 0x02, },
 	{ 16 * 999.99        , 0x08, },
 };
 

--
