Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTKIRPn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 12:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTKIRPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 12:15:43 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:34234 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262725AbTKIRPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 12:15:42 -0500
Message-ID: <3FAE77B7.8040901@pacbell.net>
Date: Sun, 09 Nov 2003 09:21:59 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, colin@colino.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6 : cdc_acm problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that cdc_acm calls a "softirq-only" routine
in a hardirq context.  See this patch:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=106764585001038&w=2

It's not clear that'll make it into 2.6.0-final.

- Dave


