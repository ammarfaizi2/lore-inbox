Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbUKTKCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbUKTKCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 05:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbUKTKCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 05:02:45 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:45453 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261490AbUKTKCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 05:02:44 -0500
Date: Sat, 20 Nov 2004 11:02:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jan Beulich <JBeulich@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: inline (and variants) function modifier
In-Reply-To: <s19df451.058@emea1-mh.id2.novell.com>
Message-ID: <Pine.LNX.4.53.0411201102020.11800@yvahk01.tjqt.qr>
References: <s19df451.058@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>May I ask how one is supposed to write a non-static function and let the
>compiler decide whether it is worth inlining? Since all of 'inline',
>'__inline', and '__inline__' get __attribute__((always_inline))
>attached, I can't see how I would currently do this. Wouldn't it make
>sense to leave at least one of the three with its original meaning?

The only way I see ATM is to:
#undef inline

Then inline and __attribute__((always_inline)) are "independent" again.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
