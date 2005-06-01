Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVFAVWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVFAVWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVFAVVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:21:11 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:20124 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261195AbVFAVTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:19:16 -0400
Message-ID: <429E2639.70906@brturbo.com.br>
Date: Wed, 01 Jun 2005 18:18:49 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] tuner-core.c improvments and Ymec Tvision TVF8533MF support
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tuner-core.c, tuner.h:

        - tuner-core changed to support multiple I2C devices used on
some adapters;
        - Kconfig now has an option (CONFIG_TUNER_MULTI_I2C) to enable
this new behavor;
        - By default, even enabling CONFIG_TUNER_MULTI_I2C, tuner-core
emulates the old behavor,  using first I2C device for both FM and TV;
        - There is a new i2c command (TUNER_SET_ADDR) to allow tuner
clients to select I2C address for FM or TV tuner;
        - Tuner I2C dettach now generates a warning on syslog if failed.

tuner-simple.c:
        - TVision TVF-8531MF and TVF-5533 MF tuner included. It uses, by
default, I2C on 0xC2 address for TV and on 0xC0 for Radio. Both TV and
FM Radio mode are working.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
