Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbULUVV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbULUVV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 16:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbULUVV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 16:21:59 -0500
Received: from main.gmane.org ([80.91.229.2]:19390 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261366AbULUVV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 16:21:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Shankar Unni <shankarunni@netscape.net>
Subject: Re: at_fork & at_exit
Date: Tue, 21 Dec 2004 12:59:05 -0800
Message-ID: <cqa2qq$rma$1@sea.gmane.org>
References: <41C835C7.2010203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-120-146-125.dsl.snfc21.pacbell.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041201 Thunderbird/1.0RC1 Mnenhy/0.7
X-Accept-Language: en-us, en
In-Reply-To: <41C835C7.2010203@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arun C Murthy wrote:

> Im looking for linux equivalent of the FreeBSD calls:
> 1. at_fork
> 2. at_exit

There is an ANSI C equivalent of at_exit: it's called atexit(). Use that 
  instead of OS-specific hacks like at_exit.

No direct analog to at_fork() that I know of, but there's a "sort of" 
equivalent thing you can use: pthread_atfork(). No reason why you can't 
use it, even if your program is not multi-threaded..

