Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVF1IW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVF1IW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVF1IWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:22:24 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:47871 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261631AbVF1ISe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:18:34 -0400
Message-ID: <42C107CC.8070800@stud.feec.vutbr.cz>
Date: Tue, 28 Jun 2005 10:18:20 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kswapd flaw
References: <200506280637.JAA07333@raad.intranet>
In-Reply-To: <200506280637.JAA07333@raad.intranet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Kswapd starts evicting processes to fullfil a malloc, when it should just
> deny it because there is no swap.

The kernel can always discard pages of executables and read-only mapped 
files, because it can load them back if necessary. If you don't like 
this, call mlockall() in your program.

Michal
