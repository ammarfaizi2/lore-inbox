Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVC3X6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVC3X6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 18:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVC3X6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 18:58:07 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:4836 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262582AbVC3X6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 18:58:04 -0500
Date: Wed, 30 Mar 2005 17:57:49 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Big GCC bug!!! [Was: Re: Do not misuse Coverity please]
In-reply-to: <3NUDL-DU-13@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <424B3CFD.5050402@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3NC4e-1X1-21@gated-at.bofh.it> <3NGrd-5rX-21@gated-at.bofh.it>
 <3NQgW-5h6-41@gated-at.bofh.it> <3NR3q-5YI-59@gated-at.bofh.it>
 <3NUDL-DU-13@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> Dereferencing null pointers is relied upon by a number of various
> emulators and such, and is "platform-defined" in the standard, so
> since Linux allows mmap at NULL, GCC shouldn't optimize that case
> any differently.

 From the GCC manual: "The compiler assumes that dereferencing a null 
pointer would have halted the program. If a pointer is checked after it 
has already been dereferenced, it cannot be null. In some environments, 
this assumption is not true, and programs can safely dereference null 
pointers. Use -fno-delete-null-pointer-checks to disable this 
optimization for programs which depend on that behavior. "

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

