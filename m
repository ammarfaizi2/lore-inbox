Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274873AbRIUXtG>; Fri, 21 Sep 2001 19:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274874AbRIUXs4>; Fri, 21 Sep 2001 19:48:56 -0400
Received: from member.michigannet.com ([207.158.188.18]:4 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S274873AbRIUXsn>; Fri, 21 Sep 2001 19:48:43 -0400
Date: Fri, 21 Sep 2001 19:48:00 -0400
From: Paul <set@pobox.com>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac13
Message-ID: <20010921194800.T16708@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010921192411.A3181@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010921192411.A3181@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Fri, Sep 21, 2001 at 07:24:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	It looks to me like fmt got incremented once too much.
(seems to have fixed the sscanf failures I otherwise had.)

Paul
set@pobox.com

--- 2.4.9-ac13-user/lib/vsprintf.c.old	Fri Sep 21 19:42:25 2001
+++ 2.4.9-ac13-user/lib/vsprintf.c	Fri Sep 21 19:37:38 2001
@@ -526,7 +526,7 @@
 
 		/* anything that is not a conversion must match exactly */
 		if (*fmt != '%') {
-			if (*fmt++ != *str++)
+			if (*fmt != *str++)
 				return num;
 			continue;
 		}
