Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVBKTYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVBKTYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 14:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVBKTY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 14:24:29 -0500
Received: from projekt.yoobay.net ([62.111.67.101]:57264 "EHLO
	bullshit.yoobay.net") by vger.kernel.org with ESMTP id S262308AbVBKTWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 14:22:04 -0500
Message-ID: <420D05DE.6020706@qanu.de>
Date: Fri, 11 Feb 2005 20:22:06 +0100
From: Holger Waechtler <holger@qanu.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb-maintainer] [RFC: 2.6 patch] DVB: possible cleanups
References: <20050211163436.GB2958@stusta.de>
In-Reply-To: <20050211163436.GB2958@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>Before I'm getting flamed to death:
>This patch contains possible cleanups. If parts of this patch conflict 
>with pending changes these parts of my patch have to be dropped.
>
>This patch contains the following possible cleanups:
>- make needlessly global code static
>- remove the following EXPORT_SYMBOL'ed but unused function:
>  - bt8xx/bt878.c: bt878_find_by_i2c_adap
>- remove the following unused global functions:
>  - dvb-core/dvb_demux.c: dmx_get_demuxes
>  - dvb-core/dvb_demux.c: dvb_set_crc32
>- remove the following unneeded EXPORT_SYMBOL's:
>  - dvb-core/dvb_demux.c: dvb_dmx_swfilter_packet
>  
>

dvb_dmx_swfilter_packet() should remain exported to the public, 
accessing this directly makes sense for some architectures.

Holger

