Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbULQENx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbULQENx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 23:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbULQENw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 23:13:52 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:44037 "EHLO
	linmail.globaledgesoft.com") by vger.kernel.org with ESMTP
	id S262491AbULQENQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 23:13:16 -0500
Message-ID: <41C25BDC.8080404@globaledgesoft.com>
Date: Fri, 17 Dec 2004 09:39:00 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Significance of do ... while (0)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

    Can any one explain the importance of do  ... while (0)

Regards,
Krishna Chaitanya

#define STATS_SET_HIGH(x)       do { if ((x)->num_active > (x)->high_mark) \
                                        (x)->high_mark = (x)->num_active; \
                                } while (0)
#define STATS_INC_ERR(x)        ((x)->errors++)
#define STATS_SET_FREEABLE(x, i) \
                                do { if ((x)->max_freeable < i) \
                                        (x)->max_freeable = i; \
                                } while (0)
                                                                                                                              
 
#define STATS_INC_ALLOCHIT(x)   atomic_inc(&(x)->allochit)
#define STATS_INC_ALLOCMISS(x)  atomic_inc(&(x)->allocmiss)
#define STATS_INC_FREEHIT(x)    atomic_inc(&(x)->freehit)
#define STATS_INC_FREEMISS(x)   atomic_inc(&(x)->freemiss)
#else
#define STATS_INC_ACTIVE(x)     do { } while (0)
#define STATS_DEC_ACTIVE(x)     do { } while (0)
#define STATS_INC_ALLOCED(x)    do { } while (0)
#define STATS_INC_GROWN(x)      do { } while (0)
#define STATS_INC_REAPED(x)     do { } while (0)
#define STATS_SET_HIGH(x)       do { } while (0)
#define STATS_INC_ERR(x)        do { } while (0)
#define STATS_SET_FREEABLE(x, i) \
                                do { } while (0)
                                                                                                                              
 
#define STATS_INC_ALLOCHIT(x)   do { } while (0)
#define STATS_INC_ALLOCMISS(x)  do { } while (0)
#define STATS_INC_FREEHIT(x)    do { } while (0)
#define STATS_INC_FREEMISS(x)   do { } while (0)

