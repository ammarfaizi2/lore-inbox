Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272264AbRIESyr>; Wed, 5 Sep 2001 14:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272261AbRIESyh>; Wed, 5 Sep 2001 14:54:37 -0400
Received: from patan.Sun.COM ([192.18.98.43]:5296 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S272187AbRIESy1>;
	Wed, 5 Sep 2001 14:54:27 -0400
Message-ID: <3B967540.2703E765@sun.com>
Date: Wed, 05 Sep 2001 11:56:00 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: sysctl() strategy questions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I've noticed an anomaly, and am not sure which behavior is correct:

sysctl_string() stores the value it reads to table->data
sysctl_intvec() validates but does not store the value it reads

whereas

proc_intvec() does store the intvec it reads, but does not validate
proc_dostring() stores the string it read


Should sysctl_intvec() be storing the data, or should sysctl_string() NOT? 
Or is this oddness by design?

Also, what is the typical answer to a sysctl variable that is essentially
an enum?  Ideally the /proc interface can show it as a meaningful string,
but should the sysctl() interface pass the integer values (cleaner)? 
Should I toss an enum into sysctl.h ?

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
