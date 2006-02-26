Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWBZQIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWBZQIv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 11:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWBZQIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 11:08:51 -0500
Received: from [217.147.92.49] ([217.147.92.49]:23957 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751248AbWBZQIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 11:08:50 -0500
Date: Sun, 26 Feb 2006 16:07:30 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Extra keycodes
Message-ID: <20060226160730.GA5853@srcf.ucam.org>
References: <20060223175328.GA25482@srcf.ucam.org> <200602242300.58815.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602242300.58815.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 11:00:58PM -0500, Dmitry Torokhov wrote:

> Just post a patch adding it to input.h and we'll discuss... Who is intended
> user? What interface is expected to be used (evdev)?

Patch included. We have code to pop up battery information in 
gnome-power-manager in response to this key being pressed, and evdev is 
the current interface for getting the keypress event.

diff --git a/include/linux/input.h b/include/linux/input.h
index 3c58233..1714630 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -344,6 +344,8 @@ struct input_absinfo {
 #define KEY_SAVE		234
 #define KEY_DOCUMENTS		235
 
+#define KEY_BATTERY             236
+
 #define KEY_UNKNOWN		240
 
 #define BTN_MISC		0x100


-- 
Matthew Garrett | mjg59@srcf.ucam.org
