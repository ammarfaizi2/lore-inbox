Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268753AbUJPPRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268753AbUJPPRC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 11:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268755AbUJPPRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 11:17:02 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:37274 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268753AbUJPPRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 11:17:00 -0400
Message-ID: <41713B79.3080406@drzeus.cx>
Date: Sat, 16 Oct 2004 17:17:13 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: nhorman@redhat.com, hancockr@shaw.ca
Subject: Re: Tasklet usage?
References: <416FCD3E.8010605@drzeus.cx>
In-Reply-To: <416FCD3E.8010605@drzeus.cx>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I was digging through the functions there was one thing that struck 
me. The parameter for the tasklet is of type unsigned long, not void*. 
Since the parameter in most cases is a pointer this might cause problems 
on 64-bit systems. Or does the kernel do some magic to map kernel memory 
in the first 4 GB?

Rgds
Pierre

