Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVIHWX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVIHWX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVIHWXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:23:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:36286 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965043AbVIHWWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:55 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Fixed 64bit compilation warning.
In-Reply-To: <11262181601746@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:41 -0700
Message-Id: <11262181611488@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Fixed 64bit compilation warning.

Fixed 64bit compilation warning.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5e8eb8501212eb92826ccf191f9ca8c186f531c3
tree 20008154898e8964b12ed86ecd767eff87b462bf
parent 7f772ed8df27c6941952452330c618512389c4c7
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Thu, 11 Aug 2005 13:45:54 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:26 -0700

 drivers/w1/w1.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -373,7 +373,7 @@ static int w1_hotplug(struct device *dev
 	if (err)
 		return err;
 
-	err = add_hotplug_env_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_SLAVE_ID=%024llX", sl->reg_num.id);
+	err = add_hotplug_env_var(envp, num_envp, &cur_index, buffer, buffer_size, &cur_len, "W1_SLAVE_ID=%024LX", (u64)sl->reg_num.id);
 	if (err)
 		return err;
 

