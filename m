Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWJYSYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWJYSYz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 14:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWJYSYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 14:24:55 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:530 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1030262AbWJYSYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 14:24:54 -0400
Message-ID: <453FABF5.6080209@superbug.co.uk>
Date: Wed, 25 Oct 2006 19:24:53 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.7 (X11/20061020)
MIME-Version: 1.0
To: Lehner franz <hamtitampti@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: Network: Duplicate MAC adress response in multihomed system
 : All Kernels
References: <aa4884ff0610241353m4bc1ebebh92191fbf8aef9178@mail.gmail.com>
In-Reply-To: <aa4884ff0610241353m4bc1ebebh92191fbf8aef9178@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lehner franz wrote:
> Maybe it is a setting, i have searched everywhere, but this is really 
> mysterious
> 
> take a linux, configure this kind
> 
> eth0: 192.168.10.200 / 255.255.255.0
> eth1: 192.168.10.201 / 255.255.255.0
> 
> Both Interfaces are "real ethernet cards" and are connected to same switch
> 
> if you take now a 3'rd machine, and do a
> 
> arping  -c 1 192.168.10.200
>> 60 bytes from 00:0c:29:bc:96:fe ( 192.168.10.200): index=0 
>> time=645.876 usec
>> 60 bytes from 00:0c:29:bc:96:f4 ( 192.168.10.200): index=1 time=1.472 
>> msec
> 
> arping  -c 1 192.168.10.201
>> 60 bytes from 00:0c:29:bc:96:fe (192.168.10.201 ): index=0 
>> time=833.988 usec
>> 60 bytes from 00:0c:29:bc:96:f4 (192.168.10.201): index=1 time=1.211 msec
> 

This behavior is correct. You should not set up a network in the way you 
have. Look at "bonding" for a better way to set up a system with 
multiple physical interfaces on the same subnetwork.

James


