Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936527AbWLARE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936527AbWLARE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936528AbWLARE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:04:58 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:56239 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S936527AbWLARE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:04:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pzH6wLHRa2v266DOkqjvf2HkrNsnot21+lYBEKUbJ+fhRCE8T57oZl4SQAkUOBAP3ud+EJo4SC2P7fz5zBHzpx8I/XwlZzfVdALdnuhAZ+wy6PxsBbj9DVogm7d+d2gHWP+5NDufRVyDLiEPYtT534jy21C13VO3KaUxpjtWX6c=
Message-ID: <5d96567b0612010904s361b799t8db72accc287ca54@mail.gmail.com>
Date: Fri, 1 Dec 2006 19:04:57 +0200
From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
To: linux-aio@kvack.org, "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: slow io_submit
Cc: jens.axboe@oracle.com, suparna@in.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens suparna hello

I have managed to understand why io_submit is sometimes very slow.
It is because the device is plugged once too many io's are being sent.
I have conducted a simple test with nr_request to default value of 128
and and 256.
and it proved to be correct.

I would truely appreciate your comment on this.
-- 
Raz
