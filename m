Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTKGXHm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTKGWXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:23:35 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:34986 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263945AbTKGIhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 03:37:01 -0500
Message-Id: <5.1.0.14.2.20031107093114.00a8bec8@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 07 Nov 2003 09:36:10 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.4.23pre mm/slab.c error
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: SmEBjsZa8e0GW06NM-t+iMUzsUT4pVyH8Eb6g2dpjx5vHez09G7TQb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At lines 1786 to 1793 in mm/slab.c we have :
                 while (p != &searchp->slabs_free) {
#if DEBUG
                         slabp = list_entry(p, slab_t, list);

                         if (slabp->inuse)
                                 BUG();
#endif
                         full_free++;

I think the "slabp =" should be above the "#if DEBUG".
Or ?

Margit


