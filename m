Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130255AbQLETzG>; Tue, 5 Dec 2000 14:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130218AbQLETyr>; Tue, 5 Dec 2000 14:54:47 -0500
Received: from 194-73-188-168.btconnect.com ([194.73.188.168]:37383 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129867AbQLETyk>;
	Tue, 5 Dec 2000 14:54:40 -0500
Date: Tue, 5 Dec 2000 19:26:16 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: check_lock() in d_move() and switch_names()?
Message-ID: <Pine.LNX.4.21.0012051913021.1493-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The check for BKL in d_move() and switch_names() seem to be unnecessary as
d_move() takes dcache_lock and switch_names() is only called by
d_move(). So, if the callers take BKL just for the sake of d_move() they
do not need to, but if, for other reasons, then that is fine. In any case,
the checks in both functions can be removed, imho. Opinions?

Regards.
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
