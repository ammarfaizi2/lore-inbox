Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbUKBVWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUKBVWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbUKBVWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:22:08 -0500
Received: from mail1.kontent.de ([81.88.34.36]:6330 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261409AbUKBVV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:21:59 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: question on common error-handling idiom
Date: Tue, 2 Nov 2004 22:21:55 +0100
User-Agent: KMail/1.6.2
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <4187E920.1070302@nortelnetworks.com> <Pine.LNX.4.61.0411022208390.3285@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0411022208390.3285@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200411022221.55857.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> but for the places that do
> 
> err = -SOMEERROR;
> if (condition)
> 	goto out;
> 
> err = -OTHERERROR;
> if (condition)
> 	goto out;
> 
> I would tend to agree with you that moving the setting of the error inside 
> the if() would make sense.

The intention is to allow the compiler to turn the if into a simple
conditional branch on the assumption that gcc is not smart enough
to put the if's body out of line.

	Regards
		Oliver
