Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWIHRNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWIHRNw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 13:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWIHRNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 13:13:52 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:48222 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750789AbWIHRNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 13:13:51 -0400
Message-ID: <4501A5B5.8050801@openvz.org>
Date: Fri, 08 Sep 2006 21:17:41 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: [PATCH] add a note about "format=flowed" when sending patches
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add a note about "format=flowed" when sending patches
and explain how to fix mozilla. Thunderbird has the similar
options.

Signed-Off-By: Kirill Korotaev <dev@openvz.org>


--- ./Documentation/SubmittingPatches.xdoc	2006-09-01 13:12:05.000000000 +0400
+++ ./Documentation/SubmittingPatches	2006-09-08 21:11:44.000000000 +0400
@@ -209,6 +209,19 @@ Exception:  If your mailer is mangling p
 you to re-send them using MIME.
 
 
+WARNING: Some mailers like Mozilla send your messages with
+---- message header ----
+Content-Type: text/plain; charset=us-ascii; format=flowed
+---- message header ----
+The problem is that "format=flowed" makes some of the mailers
+on receiving side to replace TABs with spaces and do similar
+changes. Thus the patches from you can look corrupted.
+
+To fix this just make your mozilla defaults/pref/mailnews.js file to look like:
+pref("mailnews.send_plaintext_flowed", false); // RFC 2646=======
+pref("mailnews.display.disable_format_flowed_support", true);
+
+
 
 7) E-mail size.
 

