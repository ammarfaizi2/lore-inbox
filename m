Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbUKBVjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbUKBVjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbUKBVdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:33:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:11730 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261834AbUKBVco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:32:44 -0500
Date: Tue, 2 Nov 2004 22:29:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on common error-handling idiom
In-Reply-To: <Pine.LNX.4.61.0411022208390.3285@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.53.0411022229070.6104@yvahk01.tjqt.qr>
References: <4187E920.1070302@nortelnetworks.com>
 <Pine.LNX.4.61.0411022208390.3285@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There are some places that do
>
>err = -SOMEERROR;
>if (some_error)
>	goto out;
>if (some_other_error)
>	goto out;
>if (another_error)
>	goto out;
>
>Let's see what other people think :)

err = -ESOME;
if(some_error || some_other_error || another_error) {
	goto out;
}

Best.

Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
