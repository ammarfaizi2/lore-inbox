Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVBKJgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVBKJgG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVBKJgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:36:05 -0500
Received: from projekt.yoobay.net ([62.111.67.101]:55461 "EHLO
	bullshit.yoobay.net") by vger.kernel.org with ESMTP id S262072AbVBKJgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 04:36:02 -0500
Message-ID: <420C7C83.4070309@qanu.de>
Date: Fri, 11 Feb 2005 10:36:03 +0100
From: Holger Waechtler <holger@qanu.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andreas Oberritter <obi@linuxtv.org>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, Linux-dvb <Linux-dvb@linuxtv.org>,
       Andreas Oberritter <andreas@oberritter.de>
Subject: Re: [linux-dvb-maintainer] DVB at76c651.c driver seems to be dead
 code
References: <20050210235605.GN2958@stusta.de>
In-Reply-To: <20050210235605.GN2958@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>I didn't find any way how the drivers/media/dvb/frontends/at76c651.c 
>driver would do anything inside kernel 2.6.11-rc3-mm2. All it does is to 
>EXPORT_SYMBOL a function at76c651_attach that isn't used anywhere.
>
>Is a patch to remove this driver OK or did I miss anything?
>  
>

no, please let it there. This driver is the GPL'd part of the dbox2 
driver which is not part of the official kernel tree.

Since frontend and demod drivers are reusable elsewhere and mainstream 
hardware that makes use of this demodulator may show up every week it's 
just stupid to remove this code as long we know it is working and 
continously tested by the dbox2 folks.

Instead it may make sense to move the dbox2 sources into the mainstream 
source tree. Andreas, what do you think?

Holger

