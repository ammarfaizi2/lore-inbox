Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293588AbSBRCxZ>; Sun, 17 Feb 2002 21:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293591AbSBRCxQ>; Sun, 17 Feb 2002 21:53:16 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:38482 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S293588AbSBRCxK>; Sun, 17 Feb 2002 21:53:10 -0500
Message-ID: <3C706965.8000304@sbcglobal.net>
Date: Sun, 17 Feb 2002 18:39:33 -0800
From: walt <wsheets@sbcglobal.net>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020216
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.2.18-rc1] sis.o missing symbol errors (still)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid missing-symbol errors for drm/sis.o
*all* of the following options must be set, even though
the specified SiS chips are not being used:

CONFIG_FB=y
CONFIG_FB_SIS=y/m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y

These settings are selected in the FrameBuffer support
section of .config, quite separate and distinct from

CONFIG_AGP
CONFIG_AGP_SIS
CONFIG_DRM

It would save lots of confusion if these constraints
were enforced during 'make config'.

