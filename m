Return-Path: <linux-kernel-owner+w=401wt.eu-S1751141AbXAFCgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbXAFCgr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbXAFCcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:32:43 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36814 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbXAFCcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:32:08 -0500
Message-Id: <20070106023555.137152000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:32 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Hans Verkuil <hverkuil@xs4all.nl>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [patch 39/50] V4L: cx2341x: audio_properties is an u16, not u8
Content-Disposition: inline; filename=v4l-cx2341x-audio_properties-is-an-u16-not-u8.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

This bug broke the MPEG audio mode controls.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
(cherry picked from commit cb2c7b4927c8f376b7ba9557978d8c59ed472664)

 include/media/cx2341x.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.1.orig/include/media/cx2341x.h
+++ linux-2.6.19.1/include/media/cx2341x.h
@@ -49,7 +49,7 @@ struct cx2341x_mpeg_params {
 	enum v4l2_mpeg_audio_mode_extension audio_mode_extension;
 	enum v4l2_mpeg_audio_emphasis audio_emphasis;
 	enum v4l2_mpeg_audio_crc audio_crc;
-	u8 audio_properties;
+	u16 audio_properties;
 
 	/* video */
 	enum v4l2_mpeg_video_encoding video_encoding;

--
