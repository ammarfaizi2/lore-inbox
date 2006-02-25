Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932674AbWBYEqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbWBYEqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbWBYEqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:46:43 -0500
Received: from mx0.towertech.it ([213.215.222.73]:38071 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932674AbWBYEqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:46:42 -0500
Date: Sat, 25 Feb 2006 05:46:19 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.16-rc4-mm2: drivers/rtc/utils.c should become part of a
 generic implementation
Message-ID: <20060225054619.149db264@inspiron>
In-Reply-To: <20060225033118.GF3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
	<20060225033118.GF3674@stusta.de>
Organization: Tower Technologies
X-Mailer: Sylpheed
Importance: high
X-Priority: 1 (Highest)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2006 04:31:18 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> Always building drivers/rtc/utils.o even if no RTC support is enabled 
> seems to be a workaround for an issue that should instead be fixed 
> properly:
> 
> The code in e.g. fs/udf/udftime.c or drivers/scsi/ips.c has some 
> overlaps with what you are adding (they are not doing exactly the 
> same, but there are overlaps).
> 
> We should have one common set of defines/inlines/functions dealing with 
> all these time conversion, leap year, length of months/years etc. issues 
> instead of adding one more implementation in this area.

 I agree. My idea was to place those routines in utils.o and then
 modify callers, like udftime.c and ips.c to use them. What is currently
 in utils.c has been gathered from files that were known to me,
 lice rtctime.c in the arm arch and some rtc drivers. Once deployed,
 it will be easier to find and convert similar routines.y

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

