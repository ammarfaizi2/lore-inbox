Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTFBUT3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbTFBUT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:19:29 -0400
Received: from ponch.itc.health.ufl.edu ([159.178.78.204]:36231 "EHLO
	ponch.itc.health.ufl.edu") by vger.kernel.org with ESMTP
	id S261852AbTFBUT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:19:28 -0400
Message-ID: <1054585974.3edbb476325aa@webmail.health.ufl.edu>
Date: Mon,  2 Jun 2003 16:32:54 -0400
From: sridhar vaidyanathan <sridharv@ufl.edu>
To: linux-kernel@vger.kernel.org
Subject: /dev/raw and /dev/mem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 163.181.251.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I attempetd to transfer data from a raw char device to a buffer allocated by 
mmaping /dev/mem. But the operation failed with 'Bad Address'.Upon a bit of 
investigation I found that VM_IO flag is set in the mmaped pages.get_user_pages
() which is called by the raw character driver doesn't like this.I am not very 
clear about the reason.
Is it not possible to do this?
-sridhar
ps: email me as i am not subscribed.
