Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUALKdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 05:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUALKdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 05:33:12 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:25743 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266147AbUALKdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 05:33:10 -0500
Date: Mon, 12 Jan 2004 11:32:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kieran <kieran@ihateaol.co.uk>, Bastien Nocera <hadess@hadess.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uk keyboard broken by input updates?
Message-ID: <20040112103256.GA4038@ucw.cz>
References: <1073901824.29420.14.camel@bnocera.surrey.redhat.com> <40027510.1080600@ihateaol.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40027510.1080600@ihateaol.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 10:21:04AM +0000, Kieran wrote:
> I have exactly the same problem using 2.6.1 and an IBM USB keyboard, not 
> really had a chance to look into it yet though.

Can you check if this fixes it for you?

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Sun Jan 11 19:42:55 2004
+++ b/drivers/char/keyboard.c	Sun Jan 11 19:42:55 2004
@@ -941,8 +941,8 @@
 	 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
 	 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
 	 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
-	 80, 81, 82, 83, 84, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
-	284,285,309,311,312, 91,327,328,329,331,333,335,336,337,338,339,
+	 80, 81, 82, 83, 43, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
+	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
 	367,288,302,304,350, 89,334,326,116,377,109,111,126,347,348,349,
 	360,261,262,263,298,376,100,101,321,316,373,286,289,102,351,355,
 	103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
