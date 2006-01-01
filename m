Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWAAXUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWAAXUT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 18:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWAAXUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 18:20:19 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:43497 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932231AbWAAXUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 18:20:18 -0500
From: Peter Missel <peter.missel@onlinehome.de>
To: video4linux-list@redhat.com
Subject: Re; system keeps freezing once every 24 hours / random apps crashing
Date: Mon, 2 Jan 2006 00:20:11 +0100
User-Agent: KMail/1.9.1
Cc: Mark v Wolher <trilight@ns666.com>, Jiri Slaby <xslaby@fi.muni.cz>,
       Sami Farin <7atbggg02@sneakemail.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>, jesper.juhl@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, s0348365@sms.ed.ac.uk,
       rlrevell@joe-job.com, arjan@infradead.org
References: <200512310027.47757.s0348365@sms.ed.ac.uk> <20060101191221.7E34322AEAC@anxur.fi.muni.cz> <43B82F87.5010804@ns666.com>
In-Reply-To: <43B82F87.5010804@ns666.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601020020.12190.peter.missel@onlinehome.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:eea5ddcdb9e55c285e39b42944f081ba
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But i wonder, can you think of something why grabdisplay causes crashes
> and overlay doesn't ? This needed patch, would it solve this problem too ?

Grabdisplay causes (roughly) twice the traffic. Overlay mode runs the TV 
stream straight into the graphics card, peer-to-peer, while grabdisplay 
streams into RAM, lets the CPU read from there, scale, and push into the 
graphics card.
Pure overlay mode also produces zero CPU load.
