Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265100AbUFRKmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUFRKmo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 06:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUFRKmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 06:42:44 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:5326 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265100AbUFRKkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 06:40:21 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jun 2004 12:14:29 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Cc: Paul Focke <paul.focke@pandora.be>
Subject: [PATCH] v4l: radio-zoltrix fix.
Message-ID: <20040618101429.GB24904@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Patch is ObviouslyCorrect[tm], please apply,

  Gerd

----- Forwarded message from Paul Focke <paul.focke@pandora.be> -----

Date: Thu, 17 Jun 2004 12:55:12 +0200
From: Paul Focke <paul.focke@pandora.be>
Subject: [PATCH] radio-zoltrix
To: kraxel@bytesex.org
Content-Type: multipart/mixed; boundary="=-3kZZlLw+woB/Iii8zHTj"
X-Bogosity: Ham, tests=bogofilter, spamicity=0.026921, version=0.15.13

Hi,

I recently upgraded from 2.4 to kernel 2.6 & noticed that the zoltrix
radio driver was not working.  Seems like a little typo.
I tested this on my system and it's working fine now. I doubt there are
any other linux users in the world who still use this card ;-)
This is my first patch.  I tried following the guidelines as stated here
: http://www.tux.org/lkml/#s4-1 
If I forgot something, don't hesitate to contact me.

Paul Focke

--- a/drivers/media/radio/radio-zoltrix.c	2004-06-17 12:38:20.947707352
+0200
+++ b/drivers/media/radio/radio-zoltrix.c	2004-06-17 12:37:18.729166008
+0200
@@ -273,7 +273,7 @@
 	case VIDIOCGAUDIO:
 		{
 			struct video_audio *v = arg;
-			memset(&v, 0, sizeof(*v));
+			memset(v, 0, sizeof(*v));
 			v->flags |= VIDEO_AUDIO_MUTABLE | VIDEO_AUDIO_VOLUME;
 			v->mode |= zol_is_stereo(zol)
 				? VIDEO_SOUND_STEREO : VIDEO_SOUND_MONO;



----- End forwarded message -----
