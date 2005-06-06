Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVFFSjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVFFSjB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 14:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVFFSjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 14:39:01 -0400
Received: from web25804.mail.ukl.yahoo.com ([217.12.10.189]:38508 "HELO
	web25804.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261624AbVFFSi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 14:38:58 -0400
Message-ID: <20050606183854.43545.qmail@web25804.mail.ukl.yahoo.com>
Date: Mon, 6 Jun 2005 20:38:54 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Advices for a lcd driver design. (suite)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I posted an email 1 month ago because I was looking for advices to design
a driver for a lcd device (128x64 pixels) with a t6963c controller.

I have finally choosen a console implementation to interact with the lcd. It
allows me to reuse code that deals with escape character or to start a getty on
it. Unfortunately this implemenatation doens't support lcd's graphical mode.
So I wrote another small driver that can be accessed through "/dev/lcd". It
drives the lcd only in graphical mode. That means that a "echo foo > /dev/lcd"
command won't work as expected.

So now I'm wondering how to synchronize access to the lcd. Because a user appli
that is sending an image to "/dev/lcd" may want to prevent other access from
other application to the lcd either from "/dev/ttyX" or "/dev/lcd" but still
should be able to send char to "/dev/ttyX"

Any idea ?

Thanks for your answers,

         Francis


	

	
		
_____________________________________________________________________________ 
Découvrez le nouveau Yahoo! Mail : 1 Go d'espace de stockage pour vos mails, photos et vidéos ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com
