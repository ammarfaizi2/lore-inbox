Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTFKVNx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTFKVNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:13:36 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:39945 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S264491AbTFKVMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:12:07 -0400
Message-ID: <3EE79FD1.8060503@kolumbus.fi>
Date: Thu, 12 Jun 2003 00:32:01 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@serpentine.com>
CC: ak@suse.de, vojtech@suse.cz, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 12.06.2003 00:27:05,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 12.06.2003 00:26:34,
	Serialize complete at 12.06.2003 00:26:34
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/*
+ * Read the period, compute tick and quotient.
+ */
+
+	id = hpet_readl(HPET_ID);
+
+	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER) ||
+	    !(id & HPET_ID_LEGSUP))
+		return -1;
+
+	hpet_period = hpet_readl(HPET_PERIOD);
+	if (hpet_period < 100000 || hpet_period > 100000000)
+		return -1;
+


Line below seems to be wrong, given hpet period is in fsecs.


+	hpet_tick = (tick_nsec + hpet_period / 2) / hpet_period;





--Mika





