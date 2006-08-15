Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWHOXQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWHOXQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 19:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWHOXQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 19:16:40 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:15541 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750806AbWHOXQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 19:16:39 -0400
Date: Tue, 15 Aug 2006 17:12:36 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Maximum number of processes in Linux
In-reply-to: <fa.evUDdOgjejpeNWKvgan3aKFF880@ifi.uio.no>
To: Irfan Habib <irfan.habib@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <44E254E4.6090508@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.evUDdOgjejpeNWKvgan3aKFF880@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Irfan Habib wrote:
> Hi,
> 
> What is the maximum number of process which can run simultaneously in
> linux? I need to create an application which requires 40,000 threads.
> I was testing with far fewer numbers than that, I was getting
> exceptions in pthread_create

What architecture is this? On a 32-bit architecture with a 2MB stack 
size (which I think is the default) you couldn't possibly create more 
than 2048 threads just because of stack space requirements. Reducing the 
stack size would get you more.

I should also point out that any design that requires 40,000 threads is 
probably quite flawed unless you are running on a very large machine..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

