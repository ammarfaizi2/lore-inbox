Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030635AbVJ1T0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030635AbVJ1T0H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030637AbVJ1T0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:26:07 -0400
Received: from sender-02.it.helsinki.fi ([128.214.205.137]:58800 "EHLO
	sender-02.it.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030635AbVJ1T0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:26:06 -0400
Date: Fri, 28 Oct 2005 22:26:03 +0300 (EEST)
From: Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>
X-X-Sender: jmoheikk@rock.it.helsinki.fi
To: linux-kernel@vger.kernel.org
Subject: x86_64: 2.6.14 with NUMA panics at boot
Message-ID: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With CONFIG_K8_NUMA I get the following right after boot:

PANIC: early exception rip ffffffff8023429f error 0 cr2 0
PANIC: early exception rip ffffffff8011893a error 0 cr2 ffffffffff5fd023

Looking at the System.map 8023429f seems to be find_first_bit
and 80118993a safe_smp_processor_id. When I compile kernel without
K8 NUMA it boots fine but eg. ATI Radeon driver doesn work.

Board I'm using is Tyan S2885 with two Opteron 246's and 4GB ram.
