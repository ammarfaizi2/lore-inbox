Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRCFWKM>; Tue, 6 Mar 2001 17:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbRCFWKD>; Tue, 6 Mar 2001 17:10:03 -0500
Received: from hera.cwi.nl ([192.16.191.8]:28612 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129598AbRCFWJ4>;
	Tue, 6 Mar 2001 17:09:56 -0500
Date: Tue, 6 Mar 2001 23:09:23 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103062209.XAA112274.aeb@vlet.cwi.nl>
To: danko@danko.isten.vagy.hu
Subject: Re: setleds source and ppp
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> after each byte, downloaded from the internet, the CAPS LOCK led blinks.

[poor you - you must have a slow connection]

Two possibilities: (i) blink from user space,
(ii) blink from kernel space.

There is a program setleds in the kbd distribution that sets the leds.
Source fragment:

int setleds(char leds) {
    if (ioctl(0, KDSETLED, leds)) {
        perror("KDSETLED");
        return -1;
    }
    return 0;
}

There is also a kernel routine that accepts kernel calls:

See keyboard.c, routines register_leds(), setledstate().
In ancient times people used this for "blinkenlights".
Have not checked recently whether this still works.

Andries

cc'd to l-k -- no doubt there are people that'll want to play
with the lights again

