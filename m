Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270014AbTGZVCg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270092AbTGZVCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:02:36 -0400
Received: from nice-2-a7-62-147-227-200.dial.proxad.net ([62.147.227.200]:52998
	"EHLO monpc") by vger.kernel.org with ESMTP id S270014AbTGZVCb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:02:31 -0400
From: Guillaume Chazarain <gfc@altern.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Date: Sat, 26 Jul 2003 23:20:45 +0200
X-Priority: 3 (Normal)
Message-Id: <C0QOVULH73ONRLIH5282OLOWQJIF01.3f22f0ad@monpc>
Subject: Re: [PATCH] O9int for interactivity
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
X-Mailer: Opera 6.06 build 1145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

Strange your activate() function in O9. Isn't it?
It doesn't care that much about sleep_time.

So here is a very simple trouble maker.



#include <time.h>
#include <unistd.h>

int main(void)
{
    int i;

    fork();
    fork();

    for (;;) {
	clock_t c = clock();

	usleep(1);
	usleep(1);
	while (clock() <= c);
    }

    return 0;
}






