Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbTGBWxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbTGBWwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:52:15 -0400
Received: from mailgate2.sover.net ([209.198.87.64]:37371 "EHLO
	mailgate2.sover.net") by vger.kernel.org with ESMTP id S265127AbTGBWti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:49:38 -0400
Message-ID: <3F036410.9000800@sover.net>
Date: Wed, 02 Jul 2003 19:00:32 -0400
From: Stephen Wille Padnos <spadnos@sover.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kay Sievers <lkml001@vrfy.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: why does sscanf() does not interpret number length attributes?
References: <20030702203433.GA14854@vrfy.org>
In-Reply-To: <20030702203433.GA14854@vrfy.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers wrote:

[snip]

>but sscanf in linux-2.5/lib/vsprintf.c interpretes length attributes
>only when the type is a string. It uses simple_strtoul() and it will
>read the buffer until it finds a non-(hex)digit.
>  
>
[snip]
You could always try truncating the string, then using strtoul().  Save 
the character you replace if you want to restore the string to its 
former glory :)

eg.:
...
savechar = str[3];
str[3]=0;
i = simple_strtoul(str);
str[3]=savechar;
...
- Steve


