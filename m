Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVC3Evn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVC3Evn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 23:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVC3Evn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 23:51:43 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:47978 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261545AbVC3Evl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 23:51:41 -0500
Date: Tue, 29 Mar 2005 22:50:10 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Aligning file system data
In-reply-to: <3ND9P-2LV-1@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <424A3002.0@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=UTF-8
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3ND9P-2LV-1@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> How likely is it that I can actually align stuff to 31.5KiB on the
> physical disk, i.e. have each block be a track?

I don't think this is very likely. Even being able to find out what the 
physical disk arrangement is, or whether it is consistent in terms of 
track size, etc. seems unlikely.

> 
> Rather than leveraging the track cache, would it be less expensive for
> me to simply read in blocks totaling about 16 or 32KiB all at once?

For block sizes that small I think that the kernel should be smart 
enough to do this itself, there is no need to concern with such low 
level details in the application.

> How much more latency is involved in (B) than in (C)?  Does crossing a
> track boundary incur anything expensive?

Given that both the disk and the kernel will likely read far more than 
32KB ahead I can't see much difference other than the overhead inside 
your application..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

