Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVCNJen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVCNJen (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVCNJen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:34:43 -0500
Received: from web25109.mail.ukl.yahoo.com ([217.12.10.57]:14418 "HELO
	web25109.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262083AbVCNJbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:31:46 -0500
Message-ID: <20050314093145.56419.qmail@web25109.mail.ukl.yahoo.com>
Date: Mon, 14 Mar 2005 10:31:45 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: [TTY] overrun notify issue during 5 minutes after booting
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that TTY is not able to notify overrun issue
in "n_tty_receive_overrun". Actually it's because of
"time_before" macro which tests "tty->overrun_time" 
(equals to 0) against "jiffies - HZ" (something very
big
after booting).
I guess a simple way to solve it, is to initialize
"tty->overrun_time" to "jiffies". But it won't work if
an overrun appear after a very long while....

Thanks

    Francis


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
